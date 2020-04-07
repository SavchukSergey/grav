const fs = require('fs');
var source = fs.readFileSync(`./dist/${process.argv[2]}`);
var typedArray = new Uint8Array(source);

const env = {
    memory: new WebAssembly.Memory({
        initial: 256
    })
};



WebAssembly.instantiate(typedArray, {
    env: env
}).then(obj => {
    const instance = obj.instance.exports;

    function test(name, func) {

        function that(val, message) {
            if (!val) {
                throw new Error(`${name}: ${message}`);
            }
        }

        function equal(expected, actual, message) {
            if (expected !== actual) {
                throw new Error(`${name}: ${message} expected: ${expected}, actual: ${actual}`);
            }
        }

        function equalVector(expected, actual, message) {
            equalFloat(expected.x, actual.x, `${message}:x`);
            equalFloat(expected.y, actual.y, `${message}:y`);
            equalFloat(expected.z, actual.z, `${message}:z`);
        }

        function equalFloat(expected, actual, message) {
            const error = Math.abs(expected - actual);
            if (error > 1e-6) {
                throw new Error(`${name}: ${message} expected: ${expected}, actual: ${actual}`);
            }
        }

        function equalParticle(expected, handle, message) {
            if (expected.hasOwnProperty("position")) {
                const actualPosition = readVector(instance.pGetPositionPointer(handle));
                equalVector(expected.position, actualPosition, `${message}.position`)
            }
            if (expected.hasOwnProperty("velocity")) {
                const actualVelocity = readVector(instance.pGetVelocityPointer(handle));
                equalVector(expected.velocity, actualVelocity, `${message}.velocity`)
            }
            if (expected.hasOwnProperty("force")) {
                const actualForce = readVector(instance.pGetForcePointer(handle));
                equalVector(expected.force, actualForce, `${message}.force`)
            }
            if (expected.hasOwnProperty("mass")) {
                const actualMass = instance.pGetMass(handle);
                equalVector(expected.mass, actualMass, `${message}.mass`)
            }
            if (expected.hasOwnProperty("radius")) {
                const actualRadius = instance.pGetRadius(handle);
                equalVector(expected.radius, actualRadius, `${message}.radius`)
            }
        }

        function equalWorld(expected, handle, message) {
            message = message || "world";
            if (expected.hasOwnProperty("gravityConst")) {
                const actualGravityConst = instance.wGetGravityConst(handle);
                equalFloat(actualGravityConst, expected.gravityConst, `${message}.gravityConst`)
            }
            if (expected.hasOwnProperty("viscosityConst")) {
                const actualViscosityConst = instance.wGetViscosityConst(handle);
                equal(actualViscosityConst, expected.viscosityConst, `${message}.viscosityConst`)
            }
            if (expected.hasOwnProperty("particles")) {
                const expectedCount = expected.particles.length;
                equal(expectedCount, instance.wGetParticlesCount(handle), `${message}.particles.length`);
                for (let i = 0; i < expectedCount; i++) {
                    equalParticle(expected.particles[i], instance.wGetParticlePointer(handle, i), `${message}.particles[${i}]`);
                }
            }
        }

        func({
            that,
            equal,
            equalVector,
            equalFloat,
            equalWorld
        })

        console.log(`${name}: ok`)
    }

    function createWorld(info) {

        function setVector(pointer, info) {
            if (info.hasOwnProperty("x")) {
                instance.vsetx(pointer, info.x);
            }
            if (info.hasOwnProperty("y")) {
                instance.vsety(pointer, info.y);
            }
            if (info.hasOwnProperty("z")) {
                instance.vsetz(pointer, info.z);
            }
        }

        const handle = 256;
        instance.wInit(handle);
        if (info.hasOwnProperty("gravityConst")) {
            instance.wSetGravityConst(handle, info.gravityConst);
        }
        if (info.hasOwnProperty("stiffnessConst")) {
            instance.wSetStiffnessConst(handle, info.stiffnessConst);
        }
        if (info.hasOwnProperty("viscosityConst")) {
            instance.wSetViscosityConst(handle, info.viscosityConst);
        }
        if (info.hasOwnProperty("dt")) {
            instance.wSetDt(handle, info.dt);
        }
        if (info.hasOwnProperty("particles")) {
            for (const particleInfo of info.particles) {
                const particleHandle = instance.wNewParticle(handle);
                if (particleInfo.hasOwnProperty("position")) {
                    const positionPointer = instance.pGetPositionPointer(particleHandle);
                    setVector(positionPointer, particleInfo.position);
                }
                if (particleInfo.hasOwnProperty("velocity")) {
                    const velocityPointer = instance.pGetVelocityPointer(particleHandle);
                    setVector(velocityPointer, particleInfo.velocity);
                }
                if (particleInfo.hasOwnProperty("force")) {
                    const forcePointer = instance.pGetForcePointer(particleHandle);
                    setVector(forcePointer, particleInfo.force);
                }
                if (particleInfo.hasOwnProperty("mass")) {
                    instance.pSetMass(particleHandle, particleInfo.mass);
                }
                if (particleInfo.hasOwnProperty("radius")) {
                    instance.pSetRadius(particleHandle, particleInfo.radius);
                }

            }
        }
        return handle;
    }

    function dump(index) {
        const x = instance.vgetx(index);
        const y = instance.vgety(index);
        const z = instance.vgetz(index);
        console.log(`(${x}, ${y}, ${z})`);
    }


    function readVector(index) {
        const x = instance.vgetx(index);
        const y = instance.vgety(index);
        const z = instance.vgetz(index);
        return { x, y, z };
    }

    function testAdd() {
        test("vadd", assert => {
            instance.vset(0, 12.0, 13.0, 14.0);
            instance.vset(12, 10.0, 10.0, 10.0);
            instance.vadd(24, 0, 12);
            const res = readVector(24);
            assert.equalVector({ x: 22, y: 23, z: 24 }, res, "add");
        });
    }

    function testSub() {
        test("vsub", assert => {
            instance.vset(0, 12.0, 13.0, 14.0);
            instance.vset(12, 10.0, 10.0, 10.0);
            instance.vsub(24, 0, 12);
            const res = readVector(24);
            assert.equalVector({ x: 2, y: 3, z: 4 }, res, "sub");
        });
    }

    function testMulkv() {
        test("vmulkv", assert => {
            instance.vset(0, 12.0, 13.0, 14.0);
            instance.vmulkv(12, 5, 0);
            const res = readVector(12);
            assert.equalVector({ x: 60, y: 65, z: 70 }, res, "mul");
        });
    }

    function testMulvk() {
        test("vmulvk", assert => {
            instance.vset(0, 12.0, 13.0, 14.0);
            instance.vmulvk(12, 0, 5);
            const res = readVector(12);
            assert.equalVector({ x: 60, y: 65, z: 70 }, res, "mul");
        });
    }

    function testDivvk() {
        test("vdivvk", assert => {
            instance.vset(0, 60, 65, 70);
            instance.vdivvk(12, 0, 5);
            const res = readVector(12);
            assert.equalVector({ x: 12, y: 13, z: 14 }, res, "div");
        });
    }

    function testScalar() {
        test("vscalar", assert => {
            instance.vset(0, 60, 65, 70);
            instance.vset(12, 2, 13, 15);
            const res = instance.vscalar(0, 12);
            assert.equal(2015, res, "res");
        });
    }

    function testNorm() {
        test("vnorm", assert => {
            instance.vset(0, 60, 65, 70);
            instance.vnorm(12, 0);
            const res = readVector(12);
            assert.equalVector({ x: 0.5318906307220459, y: 0.5762148499488831, z: 0.6205390691757202 }, res, "norm");
        });
    }

    function testVZero() {
        test("vzero", assert => {
            instance.vset(0, 60, 65, 70);
            instance.vzero(0);
            assert.equalVector({ x: 0, y: 0, z: 0 }, readVector(0), "norm");
        });
    }

    function testPInit() {
        test("pInit", assert => {
            instance.pInit(256);
            const forcePointer = instance.pGetForcePointer(256);
            const velocityPointer = instance.pGetVelocityPointer(256);
            const positionPointer = instance.pGetPositionPointer(256);
            assert.equalVector({ x: 0, y: 0, z: 0 }, readVector(forcePointer), "force");
            assert.equalVector({ x: 0, y: 0, z: 0 }, readVector(velocityPointer), "velocity");
            assert.equalVector({ x: 0, y: 0, z: 0 }, readVector(positionPointer), "position");
        });
    }

    function testPClearForce() {
        test("pClearForce", assert => {
            instance.pClearForce(256);
            const forcePointer = instance.pGetForcePointer(256);
            const res = readVector(forcePointer);
            assert.equalVector({ x: 0, y: 0, z: 0 }, res, "pClearForce");
        });
    }

    function testPAddForce() {
        test("pAddForce", assert => {
            instance.pClearForce(256);
            instance.vset(12, 2, 13, 15);
            instance.pAddForce(256, 12);
            instance.vset(12, -1, 3, -10);
            instance.pAddForce(256, 12);
            const forcePointer = instance.pGetForcePointer(256);
            const res = readVector(forcePointer);
            assert.equalVector({ x: 1, y: 16, z: 5 }, res, "pAddForce");
        });
    }

    function testPSubForce() {
        test("pSubForce", assert => {
            instance.pClearForce(256);
            instance.vset(12, 2, 13, 15);
            instance.pSubForce(256, 12);
            instance.vset(12, -1, 3, -10);
            instance.pSubForce(256, 12);
            const forcePointer = instance.pGetForcePointer(256);
            const res = readVector(forcePointer);
            assert.equalVector({ x: -1, y: -16, z: -5 }, res, "pSubForce");
        });
    }

    function testPGetSetMass() {
        test("pGetSetMass", assert => {
            instance.pSetMass(256, 1000);
            assert.equal(1000, instance.pGetMass(256), "mass");
        });
    }

    function testPGetSetRadius() {
        test("pGetSetRadius", assert => {
            instance.pSetRadius(256, 1000);
            assert.equal(1000, instance.pGetRadius(256), "radius");
        });
    }

    function testPGetPositionPointer() {
        test("pGetPositionPointer", assert => {
            const positionPointer = instance.pGetPositionPointer(256);
            assert.equal(256 + 0, positionPointer, "positionPointer");
        });
    }

    function testPTick() {
        test("pTick", assert => {
            instance.pSetMass(256, 1000);
            const forcePointer = instance.pGetForcePointer(256);
            const velocityPointer = instance.pGetVelocityPointer(256);
            const positionPointer = instance.pGetPositionPointer(256);
            instance.vset(forcePointer, 10, 20, 30);
            instance.vset(velocityPointer, 5, 3, 10);
            instance.vset(positionPointer, 100, 200, 300);
            instance.pSetMass(256, 1024);
            const dt = 2;
            instance.pTick(256, dt);
            assert.equalVector({ x: 5 + (10 / 1024) * dt, y: 3 + (20 / 1024) * dt, z: 10 + (30 / 1024) * dt }, readVector(velocityPointer), "pTick.velocity");
            assert.equalVector({
                x: 100 + (5 + (10 / 1024) * dt) * dt,
                y: 200 + (3 + (20 / 1024) * dt) * dt,
                z: 300 + (10 + (30 / 1024) * dt) * dt
            }, readVector(positionPointer), "pTick.position");
        });
    }


    function testWInit() {
        test("wInit", assert => {
            instance.wInit(256);
            assert.equal(0, instance.wGetParticlesCount(256), "particlesCount");
            assert.equal(1, instance.wGetDt(256), "dt");
            assert.equalFloat(6.67e-11, instance.wGetGravityConst(256), "gravityConst");
        });
    }

    function testWGetParticlePointer() {
        test("wGetParticlePointer", assert => {
            instance.wInit(256);
            const p1 = instance.wGetParticlePointer(256, 0);
            const p2 = instance.wGetParticlePointer(256, 1);
            assert.equal(64, p2 - p1, "size");
        });
    }

    function testWGetSetDt() {
        test("wGetSetDt", assert => {
            instance.wSetDt(256, 0.125);
            assert.equal(0.125, instance.wGetDt(256), "wGetSetDt");
        });
    }

    function testWGetSetGravityConst() {
        test("wGetSetGravityConst", assert => {
            instance.wSetGravityConst(256, 0.125);
            assert.equal(0.125, instance.wGetGravityConst(256), "gravity");
        });
    }

    function testWGetSetStiffnessConst() {
        test("wGetSetStiffnessConst", assert => {
            instance.wSetStiffnessConst(256, 0.125);
            assert.equal(0.125, instance.wGetStiffnessConst(256), "stiffness");
        });
    }

    function testWGetSetViscosityConst() {
        test("wGetSetViscosityConst", assert => {
            instance.wSetViscosityConst(256, 0.125);
            assert.equal(0.125, instance.wGetViscosityConst(256), "viscosity");
        });
    }

    function testWNewParticle() {
        test("wNewParticle", assert => {
            instance.wInit(256);
            const p1 = instance.wNewParticle(256);
            const p2 = instance.wNewParticle(256);

            assert.equal(2, instance.wGetParticlesCount(256), "count");
            assert.equal(64, p2 - p1, "size");
        });
    }

    function testWRemoveParticle() {
        test("wRemoveParticle", assert => {
            instance.wInit(256);
            instance.wNewParticle(256);
            instance.wNewParticle(256);
            instance.wRemoveParticle(256);

            assert.equal(1, instance.wGetParticlesCount(256), "count");
        });
    }

    function testWClearForces() {
        test("wClearForces", assert => {
            instance.wInit(256);
            const p1 = instance.wNewParticle(256);
            const p2 = instance.wNewParticle(256);
            const p3 = instance.wNewParticle(256);

            const pf1 = instance.pGetForcePointer(p1);
            const pf2 = instance.pGetForcePointer(p2);
            const pf3 = instance.pGetForcePointer(p3);
            instance.vset(pf1, 1, 2, 3);
            instance.vset(pf2, 4, 5, 6);
            instance.vset(pf3, 7, 8, 9);

            instance.wRemoveParticle(256);
            instance.wClearForces(256);

            assert.equalVector({ x: 0, y: 0, z: 0 }, readVector(pf1), "pf1");
            assert.equalVector({ x: 0, y: 0, z: 0 }, readVector(pf2), "pf2");
            assert.equalVector({ x: 7, y: 8, z: 9 }, readVector(pf3), "pf3");

            instance.vset(pf1, 1, 2, 3);
            instance.vset(pf2, 4, 5, 6);
            instance.wRemoveParticle(256);
            instance.wRemoveParticle(256);
            assert.equalVector({ x: 1, y: 2, z: 3 }, readVector(pf1), "pf1");
            assert.equalVector({ x: 4, y: 5, z: 6 }, readVector(pf2), "pf2");
        });
    }

    function testWIterateGravity() {
        test("wIterateGravity", assert => {
            const world = createWorld({
                dt: 1,
                particles: [{
                    position: { x: 1, y: 2, z: 3 },
                    velocity: { x: -0.1, y: 0.2, z: 25 },
                    force: { x: 10, y: 0, z: 0 },
                    mass: 1e10
                }, {
                    position: { x: 2, y: 5, z: 7 },
                    velocity: { x: 0.3, y: 0.175, z: 0.0625 },
                    force: { x: 20, y: 0, z: 0 },
                    mass: 1e10
                }]
            })

            instance.wIteratePair(world, instance.wGetParticlePointer(world, 0), instance.wGetParticlePointer(world, 1));

            assert.equalWorld({
                particles: [{
                    position: { x: 1, y: 2, z: 3 },
                    velocity: { x: -0.1, y: 0.2, z: 25 },
                    force: { x: 50311344, y: 150933984, z: 201245328 },
                    mass: 1e10
                }, {
                    position: { x: 2, y: 5, z: 7 },
                    velocity: { x: 0.3, y: 0.175, z: 0.0625 },
                    force: { x: -50311312, y: -150933984, z: -201245328 },
                    mass: 1e10
                }]
            }, world);
        });
    }

    function testWIterateStiffness() {
        function testCase(dist, value) {
            test(`wIterateStiffness ${dist}`, assert => {
                const world = createWorld({
                    dt: 1,
                    stiffnessConst: 100,
                    gravityConst: 0,
                    viscosityConst: 0,
                    particles: [{
                        position: { x: 0, y: 0, z: 0 },
                        velocity: { x: 1, y: 1, z: 0 },
                        force: { x: 0, y: 0, z: 0 },
                        mass: 1e10,
                        radius: 10
                    }, {
                        position: { x: dist, y: 0, z: 0 },
                        velocity: { x: -1, y: 1, z: 0 },
                        force: { x: 0, y: 0, z: 0 },
                        mass: 1e10,
                        radius: 10
                    }]
                })

                instance.wIteratePair(world, instance.wGetParticlePointer(world, 0), instance.wGetParticlePointer(world, 1));

                assert.equalWorld({
                    gravityConst: 0,
                    particles: [{
                        position: { x: 0, y: 0, z: 0 },
                        velocity: { x: 1, y: 1, z: 0 },
                        force: { x: -value, y: 0, z: 0 },
                        mass: 1e10,
                        radius: 10
                    }, {
                        position: { x: dist, y: 0, z: 0 },
                        velocity: { x: -1, y: 1, z: 0 },
                        force: { x: value, y: 0, z: 0 },
                        mass: 1e10,
                        radius: 10
                    }]
                }, world);

            });
        }
        testCase(5, 337500);
        testCase(20, 0);
        testCase(25, 0);
    }

    function testWIterateViscosity() {
        test(`wIterateViscosity`, assert => {
            const world = createWorld({
                dt: 1,
                stiffnessConst: 0,
                gravityConst: 0,
                viscosityConst: 0.0001,
                particles: [{
                    position: { x: 0, y: 0, z: 0 },
                    velocity: { x: 1, y: 1, z: 0 },
                    force: { x: 0, y: 0, z: 0 },
                    mass: 1e10,
                    radius: 10
                }, {
                    position: { x: 5, y: 0, z: 0 },
                    velocity: { x: -1, y: 1, z: 0 },
                    force: { x: 0, y: 0, z: 0 },
                    mass: 1e10,
                    radius: 10
                }]
            })

            instance.wIteratePair(world, instance.wGetParticlePointer(world, 0), instance.wGetParticlePointer(world, 1));

            assert.equalWorld({
                gravityConst: 0,
                particles: [{
                    position: { x: 0, y: 0, z: 0 },
                    velocity: { x: 1, y: 1, z: 0 },
                    force: { x: -2e6, y: 0, z: 0 },
                    mass: 1e10,
                    radius: 10
                }, {
                    position: { x: 5, y: 0, z: 0 },
                    velocity: { x: -1, y: 1, z: 0 },
                    force: { x: 2e6, y: 0, z: 0 },
                    mass: 1e10,
                    radius: 10
                }]
            }, world);

        })
    }


    testAdd();
        testSub();
        testMulkv();
        testMulvk();
        testDivvk();
        testScalar();
        testNorm();
        testVZero();
        testPInit();
        testPClearForce();
        testPAddForce();
        testPSubForce();
        testPGetSetMass();
        testPGetSetRadius();
        testPGetPositionPointer();
        testPTick();
        testWInit();
        testWGetParticlePointer();
        testWGetSetDt();
        testWGetSetGravityConst();
        testWGetSetStiffnessConst();
        testWGetSetViscosityConst();
        testWNewParticle();
        testWRemoveParticle();
        testWClearForces();
        testWIterateGravity();
        testWIterateStiffness();
        testWIterateViscosity();

    }).catch(e => {
        // error caught
        console.log(e);
    });
