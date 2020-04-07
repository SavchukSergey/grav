const memory = new WebAssembly.Memory({ initial: 10, maximum: 10 });
const simd = window.location.search.indexOf("simd") > 0;
WebAssembly.instantiateStreaming(fetch(`dist/grav${simd ? ".simd" : ""}.wasm`, { mode: 'no-cors' }), { js: { mem: memory } })
    .then(obj => {
        const instance = obj.instance.exports;

        const rnds = (scale = 1) => {
            return (Math.random() * 2 - 1) * scale;
        };

        const rndvec3 = (scale = 1) => {
            return {
                x: rnds(scale),
                y: rnds(scale),
                z: rnds(scale)
            };
        };

        const addvv = (left, right) => {
            return {
                x: left.x + right.x,
                y: left.y + right.y,
                z: left.z + right.z
            };
        };

        const lenv = (vec) => {
            return Math.sqrt(vec.x * vec.x + vec.y * vec.y + vec.z * vec.z);
        };

        const rotx = (vec, alpha) => {
            const ca = Math.cos(alpha);
            const sa = Math.sin(alpha);
            return {
                x: vec.x,
                y: ca * vec.y + sa * vec.z,
                z: ca * vec.z - sa * vec.y
            }
        };

        const roty = (vec, alpha) => {
            const ca = Math.cos(alpha);
            const sa = Math.sin(alpha);
            return {
                x: ca * vec.x + sa * vec.z,
                y: vec.y,
                z: ca * vec.z - sa * vec.x
            }
        };

        const mulkv = (k, vec) => {
            return {
                x: k * vec.x,
                y: k * vec.y,
                z: k * vec.z,
            }
        };

        const scene = new THREE.Scene();
        const spotLight = new THREE.SpotLight(0xeeeece);
        spotLight.position.set(0, 0, 1000);
        scene.add(spotLight);

        const container = document.getElementById("canvas");
        const camera = new THREE.PerspectiveCamera(75, container.clientWidth / container.clientHeight, 0.1, 1e9);
        camera.position.z = 30000;
        camera.zoom = 3;
        camera.updateProjectionMatrix();
        const renderer = new THREE.WebGLRenderer({
            logarithmicDepthBuffer: true
        });
        renderer.setSize(container.clientWidth, container.clientHeight);
        document.getElementById("canvas").appendChild(renderer.domElement);

        function createWorld() {
            const handle = 256;
            const particles = [];

            function readVector(pointer) {
                return {
                    x: instance.vgetx(pointer),
                    y: instance.vgety(pointer),
                    z: instance.vgetz(pointer)
                };
            }

            return {
                particles,
                setGravityConst: g => {
                    instance.wSetGravityConst(handle, g)
                },
                setStiffnessConst: stiffness => {
                    instance.wSetStiffnessConst(handle, stiffness)
                },
                setViscosityConst: viscosity => {
                    instance.wSetViscosityConst(handle, viscosity)
                },
                setDt: dt => {
                    instance.wSetDt(handle, dt);
                },
                iterate: () => {
                    instance.wIterate(handle);
                },
                newParticle: () => {
                    const particleHandle = instance.wNewParticle(handle);
                    const posPointer = instance.pGetPositionPointer(particleHandle);
                    const velocityPointer = instance.pGetVelocityPointer(particleHandle);

                    const particle = {
                        setRadius: radius => {
                            instance.pSetRadius(particleHandle, radius);
                        },
                        setMass: val => {
                            instance.pSetMass(particleHandle, val);
                        },
                        getPosition: () => readVector(posPointer),
                        getVelocity: () => readVector(velocityPointer),
                        setPosition: (vec) => {
                            instance.vset(posPointer, vec.x, vec.y, vec.z);
                        },
                        setVelocity: (vec) => {
                            instance.vset(velocityPointer, vec.x, vec.y, vec.z);
                        }
                    };

                    particles.push(particle);
                    return particle;
                }
            };
        }

        world = createWorld();
        world.setGravityConst(6.67e-11);
        world.setStiffnessConst(500);
        world.setViscosityConst(0.002);
        world.setDt(25);


        const iterate = () => {
            world.iterate();
        };

        const draw = () => {
            const len = world.particles.length;
            const center = camera.position;
            for (let i = 0; i < len; i++) {
                const particle = world.particles[i];
                const { sphere } = particle;
                const position = particle.getPosition();
                sphere.position.x = position.x;
                sphere.position.y = position.y;
                sphere.position.z = -position.z;
            }
            renderer.render(scene, camera);
            document.getElementById("count").innerText = `count: ${world.particles.length}, x: ${center.x}, y: ${center.y}`;
        }

        setInterval(() => {
            for (var i = 0; i < 10; i++) {
                iterate();
            }
            draw();
        }, 100);


        const add = () => {
            const c = camera.position;
            const alpha = -Math.PI / 3;
            for (let i = 0; i < 500; i++) {
                const particle = world.newParticle();

                const radius = 75;
                const geometry = new THREE.SphereGeometry(radius, 4, 4);
                // const material = new THREE.MeshNormalMaterial();
                var material = new THREE.MeshStandardMaterial({
                    color:
                        Math.round(Math.random() * 224 + 15) * 65536 +
                        Math.round(Math.random() * 224 + 15) * 256 +
                        Math.round(Math.random() * 224 + 15)
                });
                const sphere = new THREE.Mesh(geometry, material);
                const pos = rndvec3(15000);
                pos.z *= 0.3;
                const v = addvv(rndvec3(0.00025), mulkv(0.1 / (1 + lenv(pos)), { x: -pos.y, y: pos.x, z: 0 }));
                particle.setPosition(addvv(c, rotx(pos, alpha)));
                particle.setVelocity(rotx(v, alpha));
                particle.setMass(1e10);
                particle.setRadius(radius);
                particle.sphere = sphere;
                scene.add(sphere);
            }
        }

        document.getElementById("add").addEventListener("click", add);

        document.body.addEventListener("keyup", ev => {
            const delta = 5000;
            const center = camera.position;
            switch (ev.keyCode) {
                case 38:
                    center.y += delta;
                    break;
                case 40:
                    center.y -= delta;
                    break;
                case 37:
                    center.x -= delta;
                    break;
                case 39:
                    center.x += delta;
                    break;
                case 32:
                    add();
                    break;
                case 187:
                case 107:
                    camera.zoom *= 1.2;
                    break;
                case 189:
                case 109:
                    camera.zoom /= 1.2;
                    break;
                case 83:
                    for (const p of world.particles) {
                        p.setVelocity(mulkv(0.5, p.getVelocity()));
                    }
                    break;
                case 77:
                    for (const p of world.particles) {
                        p.setVelocity(mulkv(2, p.getVelocity()));
                    }
                    break;
                default:
                    console.log(ev.keyCode);
                    break;
            }
            camera.updateProjectionMatrix();
        })
    });