(module

  (memory 4)
  
  (func $vlen2 (param $pointer i32) (result f32)
    (f32.load offset=0 (local.get $pointer))
    (f32.load offset=0 (local.get $pointer))
    (f32.mul)
    

    (f32.load offset=4 (local.get $pointer))
    (f32.load offset=4 (local.get $pointer))
    (f32.mul)

    (f32.load offset=8 (local.get $pointer))
    (f32.load offset=8 (local.get $pointer))
    (f32.mul)

    f32.add
    f32.add
  )

  (func $vlen (param $pointer i32) (result f32)
    local.get $pointer
    call $vlen2
    f32.sqrt
  )

  (func $vset (param $pointer i32) (param $x f32) (param $y f32) (param $z f32)
    (f32.store offset=0 (local.get $pointer) (local.get $x))
    (f32.store offset=4 (local.get $pointer) (local.get $y))
    (f32.store offset=8 (local.get $pointer) (local.get $z))
  )

  (func $vgetx (param $pointer i32) (result f32)
    (f32.load offset=0 (local.get $pointer))
  )

  (func $vgety (param $pointer i32) (result f32)
    (f32.load offset=4 (local.get $pointer))
  )

  (func $vgetz (param $pointer i32) (result f32)
    (f32.load offset=8 (local.get $pointer))
  )


  (func $vsetx (param $pointer i32) (param $x f32)
    (f32.store offset=0 (local.get $pointer) (local.get $x))
  )

  (func $vsety (param $pointer i32) (param $y f32)
    (f32.store offset=4 (local.get $pointer) (local.get $y))
  )

  (func $vsetz (param $pointer i32) (param $z f32)
    (f32.store offset=8 (local.get $pointer) (local.get $z))
  )
  
  (func $vadd (param $result i32 ) (param $left i32) (param $right i32) 
    (local.get $result)
    (f32.add
      (f32.load offset=0 (local.get $left))
      (f32.load offset=0 (local.get $right))
    )
    (f32.store offset=0)

    (local.get $result)
    (f32.add
      (f32.load offset=4 (local.get $left))
      (f32.load offset=4 (local.get $right))
    )
    (f32.store offset=4)

    (local.get $result)
    (f32.add
      (f32.load offset=8 (local.get $left))
      (f32.load offset=8 (local.get $right))
    )
    (f32.store offset=8)
  )

  (func $vsub (param $result i32 ) (param $left i32) (param $right i32) 
    (local.get $result)
    (f32.sub
      (f32.load offset=0 (local.get $left))
      (f32.load offset=0 (local.get $right))
    )
    (f32.store offset=0)

    (local.get $result)
    (f32.sub
      (f32.load offset=4 (local.get $left))
      (f32.load offset=4 (local.get $right))
    )
    (f32.store offset=4)

    (local.get $result)
    (f32.sub
      (f32.load offset=8 (local.get $left))
      (f32.load offset=8 (local.get $right))
    )
    (f32.store offset=8)
  )

  (func $vmulkv (param $result i32) (param $k f32) (param $vec i32) 
    (local.get $result)
    (f32.mul
      (local.get $k)
      (f32.load offset=0 (local.get $vec))
    )
    (f32.store offset=0)

    (local.get $result)
    (f32.mul
      (local.get $k)
      (f32.load offset=4 (local.get $vec))
    )
    (f32.store offset=4)

    (local.get $result)
    (f32.mul
      (local.get $k)
      (f32.load offset=8 (local.get $vec))
    )
    (f32.store offset=8)
  )

  (func $vmulvk (param $result i32) (param $vec i32) (param $k f32)
    (local.get $result)
    (f32.mul
      (local.get $k)
      (f32.load offset=0 (local.get $vec))
    )
    (f32.store offset=0)

    (local.get $result)
    (f32.mul
      (local.get $k)
      (f32.load offset=4 (local.get $vec))
    )
    (f32.store offset=4)

    (local.get $result)
    (f32.mul
      (local.get $k)
      (f32.load offset=8 (local.get $vec))
    )
    (f32.store offset=8)
  )

  (func $vdivvk (param $result i32) (param $vec i32) (param $k f32) 
    (local.get $result)
    (f32.div
      (f32.load offset=0 (local.get $vec))
      (local.get $k)
    )
    (f32.store offset=0)

    (local.get $result)
    (f32.div
      (f32.load offset=4 (local.get $vec))
      (local.get $k)
    )
    (f32.store offset=4)

    (local.get $result)
    (f32.div
      (f32.load offset=8 (local.get $vec))
      (local.get $k)
    )
    (f32.store offset=8)
  )

  (func $vscalar (param $left i32) (param $right i32) (result f32) 
    (f32.load offset=0 (local.get $left))
    (f32.load offset=0 (local.get $right))
    (f32.mul)
    
    (f32.load offset=4 (local.get $left))
    (f32.load offset=4 (local.get $right))
    (f32.mul)

    (f32.load offset=8 (local.get $left))
    (f32.load offset=8 (local.get $right))
    (f32.mul)

    f32.add
    f32.add
  )

  (func $vnorm (param $result i32) (param $vec i32)
    (call $vdivvk 
        (local.get $result)
        (local.get $vec)
        (call $vlen (local.get $vec))
    )
  )

  (func $vzero (param $vec i32)
    (f32.store offset=0 (local.get $vec) (f32.const 0))
    (f32.store offset=4 (local.get $vec) (f32.const 0))
    (f32.store offset=8 (local.get $vec) (f32.const 0))
  )


  (func $pInit (param $particle i32)
    (call $pClearForce (local.get $particle))
    (call $vzero
      (call $pGetVelocityPointer (local.get $particle))
    )
    (call $vzero
      (call $pGetPositionPointer (local.get $particle))
    )
  )

  (func $pGetForcePointer (param $particle i32) (result i32)
    (i32.add
      (local.get $particle)
      (i32.const 32)
    )
  )

  (func $pGetVelocityPointer (param $particle i32) (result i32)
    (i32.add
      (local.get $particle)
      (i32.const 16)
    )
  )

  (func $pGetPositionPointer (param $particle i32) (result i32)
    (local.get $particle)
  )

  (func $pClearForce (param $particle i32)
    (f32.store offset=32 (local.get $particle) (f32.const 0))
    (f32.store offset=36 (local.get $particle) (f32.const 0))
    (f32.store offset=40 (local.get $particle) (f32.const 0))
  )

  (func $pAddForce (param $particle i32) (param $vec i32)
    (local $forcePointer i32)

    (i32.add
        (local.get $particle)
        (i32.const 32)
    )
    (local.tee $forcePointer)

    (local.get $forcePointer)
    (local.get $vec)
    (call $vadd)
  )

  (func $pSubForce (param $particle i32) (param $vec i32)
    (local $forcePointer i32)

    (i32.add
        (local.get $particle)
        (i32.const 32)
    )
    (local.tee $forcePointer)

    (local.get $forcePointer)
    (local.get $vec)
    (call $vsub)
  )

  (func $pSetMass (param $particle i32) (param $mass f32)
    (f32.store offset=48
      (local.get $particle)
      (local.get $mass)
    )
  )

  (func $pGetMass (param $particle i32) (result f32)
    (f32.load offset=48
      (local.get $particle)
    )
  )

  (func $pSetRadius (param $particle i32) (param $radius f32)
    (f32.store offset=52
      (local.get $particle)
      (local.get $radius)
    )
  )

  (func $pGetRadius (param $particle i32) (result f32)
    (f32.load offset=52
      (local.get $particle)
    )
  )

  (func $pTick (param $particle i32) (param $dt f32)
    (local $forcePointer i32)
    (local $velocityPointer i32)
    (local.set $forcePointer
        (i32.add
            (local.get $particle)
            (i32.const 32)
        ) ;;[particle.force]
    )
    (local.set $velocityPointer
        (i32.add
            (local.get $particle)
            (i32.const 16)
        ) ;;[particle.velocity]
    )
    (call $vmulvk
        (i32.const 0)
        (local.get $forcePointer)
        (f32.div
            (local.get $dt)
            (f32.load offset=48 (local.get $particle)) ;;particle.mass
        )
    )
    (call $vadd
        (local.get $velocityPointer)
        (local.get $velocityPointer)
        (i32.const 0)
    )

    (call $vmulvk
        (i32.const 0)
        (local.get $velocityPointer)
        (local.get $dt)
    )

    (call $vadd
        (local.get $particle)
        (local.get $particle)
        (i32.const 0)
    )
  )

  

  (func $wInit (param $world i32)
    (call $wSetDt (local.get $world) (f32.const 1))
    (call $wSetGravityConst (local.get $world) (f32.const 6.67e-11))
    (call $wSetStiffnessConst (local.get $world) (f32.const 1))
    (call $wSetViscosityConst (local.get $world) (f32.const 0.0001))
    (i32.store offset=16
      (local.get $world)
      (i32.const 0)
    )
  )
  
  (func $wGetParticlesCount (param $world i32) (result i32)
    (i32.load offset=16
      (local.get $world)
    )
  )

  (func $wGetParticlePointer (param $world i32) (param $index i32) (result i32)
    (i32.add (i32.const 20)
      (i32.add
        (local.get $world)
        (i32.shl
          (local.get $index)
          (i32.const 6)
        )
      )
    )
  )

  (func $wSetDt (param $world i32) (param $dt f32)
    (f32.store offset=0
      (local.get $world)
      (local.get $dt)
    )
  )

  (func $wGetDt (param $world i32) (result f32)
    (f32.load offset=0
      (local.get $world)
    )
  )

  (func $wSetGravityConst (param $world i32) (param $val f32)
    (f32.store offset=4
      (local.get $world)
      (local.get $val)
    )
  )

  (func $wGetGravityConst (param $world i32) (result f32)
    (f32.load offset=4
      (local.get $world)
    )
  )

  (func $wSetStiffnessConst (param $world i32) (param $val f32)
    (f32.store offset=8
      (local.get $world)
      (local.get $val)
    )
  )

  (func $wGetStiffnessConst (param $world i32) (result f32)
    (f32.load offset=8
      (local.get $world)
    )
  )

  (func $wSetViscosityConst (param $world i32) (param $val f32)
    (f32.store offset=12
      (local.get $world)
      (local.get $val)
    )
  )

  (func $wGetViscosityConst (param $world i32) (result f32)
    (f32.load offset=12
      (local.get $world)
    )
  )

  (func $wNewParticle (param $world i32) (result i32)
    (local $pointer i32)
    (local.set $pointer
      (call $wGetParticlePointer 
        (local.get $world)
        (i32.load offset=16 (local.get $world))
      )
    )

    (i32.store offset=16 (local.get $world)
      (i32.add
        (i32.load offset=16 (local.get $world))
        (i32.const 1)
      )
    )

    (call $pInit (local.get $pointer))

    (local.get $pointer)
  )

  (func $wRemoveParticle (param $world i32)
    (i32.store offset=16 (local.get $world)
      (i32.sub
        (i32.load offset=16 (local.get $world))
        (i32.const 1)
      )
    )
  )

  (func $wClearForces (param $world i32)
    (local $tail i32)
    (local $pointer i32)

    (local.set $pointer
      (call $wGetParticlePointer (local.get $world) (i32.const 0))
    )
    (local.set $tail
      (call $wGetParticlePointer (local.get $world) (call $wGetParticlesCount (local.get $world)))
    )

    (loop $loop
      (call $pClearForce (local.get $pointer))
      (local.set $pointer
        (i32.add
          (local.get $pointer)
          (i32.const 64)
        )
      )
      (br_if $loop
        (i32.lt_u
          (local.get $pointer)
          (local.get $tail)
        )
      )
    )
  )

  (func $wIteratePositions (param $world i32)
    (local $tail i32)
    (local $pointer i32)
    (local $dt f32)

    (local.set $dt
      (call $wGetDt (local.get $world))
    )
    (local.set $pointer
      (call $wGetParticlePointer (local.get $world) (i32.const 0))
    )
    (local.set $tail
      (call $wGetParticlePointer (local.get $world) (call $wGetParticlesCount (local.get $world)))
    )

    (loop $loop
      (call $pTick (local.get $pointer) (local.get $dt))
      (local.set $pointer
        (i32.add
          (local.get $pointer)
          (i32.const 64)
        )
      )
      (br_if $loop
        (i32.lt_u
          (local.get $pointer)
          (local.get $tail)
        )
      )
    )
  )

  (func $wIteratePair (param $world i32) (param $left i32) (param $right i32)
      (local $len2 f32)
      (local $len f32)
      (local $minDist f32)
      (local $force f32)
      (local $penetration f32)
      (call $vsub
        (i32.const 0)
        (call $pGetPositionPointer (local.get $left))
        (call $pGetPositionPointer (local.get $right))
      )

      (local.set $len
        (f32.sqrt
          (local.tee $len2
            (call $vlen2 (i32.const 0))
          )
        )
      )

      (call $vdivvk
        (i32.const 16)
        (i32.const 0)
        (local.get $len)
      )

      (local.set $minDist
        (f32.add 
          (f32.load offset=52 (local.get $left))
          (f32.load offset=52 (local.get $right))
        )
      )

      (local.set $force
        (f32.div
            (f32.mul 
                (f32.load offset=4 (local.get $world))
                (f32.mul 
                    (f32.load offset=48 (local.get $left))
                    (f32.load offset=48 (local.get $right))
                )
            )
            (local.get $len2)
        )
      )

      (local.set $penetration
        (f32.sub (local.get $minDist) (local.get $len))
      )

      (if
        (f32.ge (local.get $penetration) (f32.const 0))
        (then 
            (local.set $force
                (f32.add
                    (local.get $force)
                    (f32.sub
                        (f32.mul
                            (f32.sub
                                (f32.mul
                                    (call $vscalar
                                        (i32.const 16)
                                        (i32.add (local.get $left) (i32.const 16))
                                    )
                                    (f32.load offset=48 (local.get $left))
                                )
                                (f32.mul
                                    (call $vscalar
                                        (i32.const 16)
                                        (i32.add (local.get $right) (i32.const 16))
                                    )
                                    (f32.load offset=48 (local.get $right))
                                )
                            )
                            (f32.load offset=12 (local.get $world))
                        )
                        
                        (f32.mul
                            (f32.load offset=8 (local.get $world))
                            (f32.mul
                                (f32.mul
                                    (local.get $penetration)
                                    (local.get $penetration)
                                )
                                
                                (local.get $penetration)
                            )
                        )
                    )
                )
            )
        )
      )

      (call $vmulvk
        (i32.const 16)
        (i32.const 16)
        (local.get $force)
      )

      (call $pSubForce (local.get $left) (i32.const 16))
      (call $pAddForce (local.get $right) (i32.const 16))
  )

  (func $wIterate (param $world i32)
    (local $tail i32)
    (local $left i32)
    (local $right i32)

    (call $wClearForces (local.get $world))
    
    (local.set $left
      (call $wGetParticlePointer (local.get $world) (i32.const 0))
    )
    (local.set $tail
      (call $wGetParticlePointer (local.get $world) (call $wGetParticlesCount (local.get $world)))
    )

    (loop $outer
      (local.set $right
        (i32.add
          (local.get $left)
          (i32.const 64)
        )
      )
    
      (loop $inner

        (call $wIteratePair (local.get $world) (local.get $left) (local.get $right))
      
        (local.set $right
          (i32.add
            (local.get $right)
            (i32.const 64)
          )
        )
        (br_if $inner
          (i32.lt_u
            (local.get $right)
            (local.get $tail)
          )
        )
      )

      (local.set $left
        (i32.add
          (local.get $left)
          (i32.const 64)
        )
      )

      (br_if $outer
        (i32.lt_u
          (local.get $left)
          (local.get $tail)
        )
      )
    )

    (call $wIteratePositions (local.get $world))
  )

;;memory

;;world
;;dt = 0
;;g = 4
;;q = 8
;;viscosity = 12
;;count 16
;;particles = 20

;;particle
;;position   0
;;velocity  16
;;force     32
;;mass      48
;;radius    52
  
  (export "vlen2" (func $vlen2))
  (export "vlen" (func $vlen))
  (export "vgetx" (func $vgetx))
  (export "vgety" (func $vgety))
  (export "vgetz" (func $vgetz))
  (export "vsetx" (func $vsetx))
  (export "vsety" (func $vsety))
  (export "vsetz" (func $vsetz))
  (export "vset" (func $vset))
  (export "vadd" (func $vadd))
  (export "vsub" (func $vsub))
  (export "vmulkv" (func $vmulkv))
  (export "vmulvk" (func $vmulvk))
  (export "vdivvk" (func $vdivvk))
  (export "vscalar" (func $vscalar))
  (export "vnorm" (func $vnorm))
  (export "vzero" (func $vzero))
  
  (export "pInit" (func $pInit))
  (export "pGetForcePointer" (func $pGetForcePointer))
  (export "pGetVelocityPointer" (func $pGetVelocityPointer))
  (export "pGetPositionPointer" (func $pGetPositionPointer))
  (export "pClearForce" (func $pClearForce))
  (export "pAddForce" (func $pAddForce))
  (export "pSubForce" (func $pSubForce))
  (export "pSetMass" (func $pSetMass))
  (export "pGetMass" (func $pGetMass))
  (export "pSetRadius" (func $pSetRadius))
  (export "pGetRadius" (func $pGetRadius))
  (export "pTick" (func $pTick))
 
  (export "wInit" (func $wInit))
  (export "wGetDt" (func $wGetDt))
  (export "wSetDt" (func $wSetDt))
  (export "wGetGravityConst" (func $wGetGravityConst))
  (export "wSetGravityConst" (func $wSetGravityConst))
  (export "wGetStiffnessConst" (func $wGetStiffnessConst))
  (export "wSetStiffnessConst" (func $wSetStiffnessConst))
  (export "wGetViscosityConst" (func $wGetViscosityConst))
  (export "wSetViscosityConst" (func $wSetViscosityConst))
  (export "wGetParticlesCount" (func $wGetParticlesCount))
  (export "wGetParticlePointer" (func $wGetParticlePointer))
  (export "wNewParticle" (func $wNewParticle))
  (export "wRemoveParticle" (func $wRemoveParticle))
  (export "wClearForces" (func $wClearForces))
  (export "wIteratePositions" (func $wIteratePositions))
  (export "wIteratePair" (func $wIteratePair))
  (export "wIterate" (func $wIterate))
)