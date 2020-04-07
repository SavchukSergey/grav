(module
  (type (;0;) (func (param i32) (result f32)))
  (type (;1;) (func (param i32 f32 f32 f32)))
  (type (;2;) (func (param i32 f32)))
  (type (;3;) (func (param i32 i32 i32)))
  (type (;4;) (func (param i32 f32 i32)))
  (type (;5;) (func (param i32 i32 f32)))
  (type (;6;) (func (param i32 i32) (result f32)))
  (type (;7;) (func (param i32 i32)))
  (type (;8;) (func (param i32)))
  (type (;9;) (func (param i32) (result i32)))
  (type (;10;) (func (param i32 i32) (result i32)))
  (func (;0;) (type 0) (param i32) (result f32)
    (f32.add
      (f32.mul
        (f32.load
          (local.get 0))
        (f32.load
          (local.get 0)))
      (f32.add
        (f32.mul
          (f32.load offset=4
            (local.get 0))
          (f32.load offset=4
            (local.get 0)))
        (f32.mul
          (f32.load offset=8
            (local.get 0))
          (f32.load offset=8
            (local.get 0))))))
  (func (;1;) (type 0) (param i32) (result f32)
    (f32.sqrt
      (call 0
        (local.get 0))))
  (func (;2;) (type 1) (param i32 f32 f32 f32)
    (f32.store
      (local.get 0)
      (local.get 1))
    (f32.store offset=4
      (local.get 0)
      (local.get 2))
    (f32.store offset=8
      (local.get 0)
      (local.get 3)))
  (func (;3;) (type 0) (param i32) (result f32)
    (f32.load
      (local.get 0)))
  (func (;4;) (type 0) (param i32) (result f32)
    (f32.load offset=4
      (local.get 0)))
  (func (;5;) (type 0) (param i32) (result f32)
    (f32.load offset=8
      (local.get 0)))
  (func (;6;) (type 2) (param i32 f32)
    (f32.store
      (local.get 0)
      (local.get 1)))
  (func (;7;) (type 2) (param i32 f32)
    (f32.store offset=4
      (local.get 0)
      (local.get 1)))
  (func (;8;) (type 2) (param i32 f32)
    (f32.store offset=8
      (local.get 0)
      (local.get 1)))
  (func (;9;) (type 3) (param i32 i32 i32)
    (f32.store
      (local.get 0)
      (f32.add
        (f32.load
          (local.get 1))
        (f32.load
          (local.get 2))))
    (f32.store offset=4
      (local.get 0)
      (f32.add
        (f32.load offset=4
          (local.get 1))
        (f32.load offset=4
          (local.get 2))))
    (f32.store offset=8
      (local.get 0)
      (f32.add
        (f32.load offset=8
          (local.get 1))
        (f32.load offset=8
          (local.get 2)))))
  (func (;10;) (type 3) (param i32 i32 i32)
    (f32.store
      (local.get 0)
      (f32.sub
        (f32.load
          (local.get 1))
        (f32.load
          (local.get 2))))
    (f32.store offset=4
      (local.get 0)
      (f32.sub
        (f32.load offset=4
          (local.get 1))
        (f32.load offset=4
          (local.get 2))))
    (f32.store offset=8
      (local.get 0)
      (f32.sub
        (f32.load offset=8
          (local.get 1))
        (f32.load offset=8
          (local.get 2)))))
  (func (;11;) (type 4) (param i32 f32 i32)
    (f32.store
      (local.get 0)
      (f32.mul
        (local.get 1)
        (f32.load
          (local.get 2))))
    (f32.store offset=4
      (local.get 0)
      (f32.mul
        (local.get 1)
        (f32.load offset=4
          (local.get 2))))
    (f32.store offset=8
      (local.get 0)
      (f32.mul
        (local.get 1)
        (f32.load offset=8
          (local.get 2)))))
  (func (;12;) (type 5) (param i32 i32 f32)
    (f32.store
      (local.get 0)
      (f32.mul
        (local.get 2)
        (f32.load
          (local.get 1))))
    (f32.store offset=4
      (local.get 0)
      (f32.mul
        (local.get 2)
        (f32.load offset=4
          (local.get 1))))
    (f32.store offset=8
      (local.get 0)
      (f32.mul
        (local.get 2)
        (f32.load offset=8
          (local.get 1)))))
  (func (;13;) (type 5) (param i32 i32 f32)
    (f32.store
      (local.get 0)
      (f32.div
        (f32.load
          (local.get 1))
        (local.get 2)))
    (f32.store offset=4
      (local.get 0)
      (f32.div
        (f32.load offset=4
          (local.get 1))
        (local.get 2)))
    (f32.store offset=8
      (local.get 0)
      (f32.div
        (f32.load offset=8
          (local.get 1))
        (local.get 2))))
  (func (;14;) (type 6) (param i32 i32) (result f32)
    (f32.add
      (f32.mul
        (f32.load
          (local.get 0))
        (f32.load
          (local.get 1)))
      (f32.add
        (f32.mul
          (f32.load offset=4
            (local.get 0))
          (f32.load offset=4
            (local.get 1)))
        (f32.mul
          (f32.load offset=8
            (local.get 0))
          (f32.load offset=8
            (local.get 1))))))
  (func (;15;) (type 7) (param i32 i32)
    (call 13
      (local.get 0)
      (local.get 1)
      (call 1
        (local.get 1))))
  (func (;16;) (type 8) (param i32)
    (f32.store
      (local.get 0)
      (f32.const 0x0p+0 (;=0;)))
    (f32.store offset=4
      (local.get 0)
      (f32.const 0x0p+0 (;=0;)))
    (f32.store offset=8
      (local.get 0)
      (f32.const 0x0p+0 (;=0;))))
  (func (;17;) (type 8) (param i32)
    (call 21
      (local.get 0))
    (call 16
      (call 19
        (local.get 0)))
    (call 16
      (call 20
        (local.get 0))))
  (func (;18;) (type 9) (param i32) (result i32)
    (i32.add
      (local.get 0)
      (i32.const 32)))
  (func (;19;) (type 9) (param i32) (result i32)
    (i32.add
      (local.get 0)
      (i32.const 16)))
  (func (;20;) (type 9) (param i32) (result i32)
    (local.get 0))
  (func (;21;) (type 8) (param i32)
    (f32.store offset=32
      (local.get 0)
      (f32.const 0x0p+0 (;=0;)))
    (f32.store offset=36
      (local.get 0)
      (f32.const 0x0p+0 (;=0;)))
    (f32.store offset=40
      (local.get 0)
      (f32.const 0x0p+0 (;=0;))))
  (func (;22;) (type 7) (param i32 i32)
    (local i32)
    (call 9
      (local.tee 2
        (i32.add
          (local.get 0)
          (i32.const 32)))
      (local.get 2)
      (local.get 1)))
  (func (;23;) (type 7) (param i32 i32)
    (local i32)
    (call 10
      (local.tee 2
        (i32.add
          (local.get 0)
          (i32.const 32)))
      (local.get 2)
      (local.get 1)))
  (func (;24;) (type 2) (param i32 f32)
    (f32.store offset=48
      (local.get 0)
      (local.get 1)))
  (func (;25;) (type 0) (param i32) (result f32)
    (f32.load offset=48
      (local.get 0)))
  (func (;26;) (type 2) (param i32 f32)
    (f32.store offset=52
      (local.get 0)
      (local.get 1)))
  (func (;27;) (type 0) (param i32) (result f32)
    (f32.load offset=52
      (local.get 0)))
  (func (;28;) (type 2) (param i32 f32)
    (local i32 i32)
    (local.set 2
      (i32.add
        (local.get 0)
        (i32.const 32)))
    (local.set 3
      (i32.add
        (local.get 0)
        (i32.const 16)))
    (call 12
      (i32.const 0)
      (local.get 2)
      (f32.div
        (local.get 1)
        (f32.load offset=48
          (local.get 0))))
    (call 9
      (local.get 3)
      (local.get 3)
      (i32.const 0))
    (call 12
      (i32.const 0)
      (local.get 3)
      (local.get 1))
    (call 9
      (local.get 0)
      (local.get 0)
      (i32.const 0)))
  (func (;29;) (type 8) (param i32)
    (call 32
      (local.get 0)
      (f32.const 0x1p+0 (;=1;)))
    (call 34
      (local.get 0)
      (f32.const 0x1.255986p-34 (;=6.67e-11;)))
    (call 36
      (local.get 0)
      (f32.const 0x1p+0 (;=1;)))
    (call 38
      (local.get 0)
      (f32.const 0x1.a36e2ep-14 (;=0.0001;)))
    (i32.store offset=16
      (local.get 0)
      (i32.const 0)))
  (func (;30;) (type 9) (param i32) (result i32)
    (i32.load offset=16
      (local.get 0)))
  (func (;31;) (type 10) (param i32 i32) (result i32)
    (i32.add
      (i32.const 20)
      (i32.add
        (local.get 0)
        (i32.shl
          (local.get 1)
          (i32.const 6)))))
  (func (;32;) (type 2) (param i32 f32)
    (f32.store
      (local.get 0)
      (local.get 1)))
  (func (;33;) (type 0) (param i32) (result f32)
    (f32.load
      (local.get 0)))
  (func (;34;) (type 2) (param i32 f32)
    (f32.store offset=4
      (local.get 0)
      (local.get 1)))
  (func (;35;) (type 0) (param i32) (result f32)
    (f32.load offset=4
      (local.get 0)))
  (func (;36;) (type 2) (param i32 f32)
    (f32.store offset=8
      (local.get 0)
      (local.get 1)))
  (func (;37;) (type 0) (param i32) (result f32)
    (f32.load offset=8
      (local.get 0)))
  (func (;38;) (type 2) (param i32 f32)
    (f32.store offset=12
      (local.get 0)
      (local.get 1)))
  (func (;39;) (type 0) (param i32) (result f32)
    (f32.load offset=12
      (local.get 0)))
  (func (;40;) (type 9) (param i32) (result i32)
    (local i32)
    (local.set 1
      (call 31
        (local.get 0)
        (i32.load offset=16
          (local.get 0))))
    (i32.store offset=16
      (local.get 0)
      (i32.add
        (i32.load offset=16
          (local.get 0))
        (i32.const 1)))
    (call 17
      (local.get 1))
    (local.get 1))
  (func (;41;) (type 8) (param i32)
    (i32.store offset=16
      (local.get 0)
      (i32.sub
        (i32.load offset=16
          (local.get 0))
        (i32.const 1))))
  (func (;42;) (type 8) (param i32)
    (local i32 i32)
    (local.set 2
      (call 31
        (local.get 0)
        (i32.const 0)))
    (local.set 1
      (call 31
        (local.get 0)
        (call 30
          (local.get 0))))
    (loop  ;; label = @1
      (call 21
        (local.get 2))
      (local.set 2
        (i32.add
          (local.get 2)
          (i32.const 64)))
      (br_if 0 (;@1;)
        (i32.lt_u
          (local.get 2)
          (local.get 1)))))
  (func (;43;) (type 8) (param i32)
    (local i32 i32 f32)
    (local.set 3
      (call 33
        (local.get 0)))
    (local.set 2
      (call 31
        (local.get 0)
        (i32.const 0)))
    (local.set 1
      (call 31
        (local.get 0)
        (call 30
          (local.get 0))))
    (loop  ;; label = @1
      (call 28
        (local.get 2)
        (local.get 3))
      (local.set 2
        (i32.add
          (local.get 2)
          (i32.const 64)))
      (br_if 0 (;@1;)
        (i32.lt_u
          (local.get 2)
          (local.get 1)))))
  (func (;44;) (type 3) (param i32 i32 i32)
    (local f32 f32 f32 f32 f32)
    (call 10
      (i32.const 0)
      (call 20
        (local.get 1))
      (call 20
        (local.get 2)))
    (local.set 4
      (f32.sqrt
        (local.tee 3
          (call 0
            (i32.const 0)))))
    (call 13
      (i32.const 16)
      (i32.const 0)
      (local.get 4))
    (local.set 5
      (f32.add
        (f32.load offset=52
          (local.get 1))
        (f32.load offset=52
          (local.get 2))))
    (local.set 6
      (f32.div
        (f32.mul
          (f32.load offset=4
            (local.get 0))
          (f32.mul
            (f32.load offset=48
              (local.get 1))
            (f32.load offset=48
              (local.get 2))))
        (local.get 3)))
    (local.set 7
      (f32.sub
        (local.get 5)
        (local.get 4)))
    (if  ;; label = @1
      (f32.ge
        (local.get 7)
        (f32.const 0x0p+0 (;=0;)))
      (then
        (local.set 6
          (f32.add
            (local.get 6)
            (f32.sub
              (f32.mul
                (f32.sub
                  (f32.mul
                    (call 14
                      (i32.const 16)
                      (i32.add
                        (local.get 1)
                        (i32.const 16)))
                    (f32.load offset=48
                      (local.get 1)))
                  (f32.mul
                    (call 14
                      (i32.const 16)
                      (i32.add
                        (local.get 2)
                        (i32.const 16)))
                    (f32.load offset=48
                      (local.get 2))))
                (f32.load offset=12
                  (local.get 0)))
              (f32.mul
                (f32.load offset=8
                  (local.get 0))
                (f32.mul
                  (f32.mul
                    (local.get 7)
                    (local.get 7))
                  (local.get 7))))))))
    (call 12
      (i32.const 16)
      (i32.const 16)
      (local.get 6))
    (call 23
      (local.get 1)
      (i32.const 16))
    (call 22
      (local.get 2)
      (i32.const 16)))
  (func (;45;) (type 8) (param i32)
    (local i32 i32 i32)
    (call 42
      (local.get 0))
    (local.set 2
      (call 31
        (local.get 0)
        (i32.const 0)))
    (local.set 1
      (call 31
        (local.get 0)
        (call 30
          (local.get 0))))
    (loop  ;; label = @1
      (local.set 3
        (i32.add
          (local.get 2)
          (i32.const 64)))
      (loop  ;; label = @2
        (call 44
          (local.get 0)
          (local.get 2)
          (local.get 3))
        (local.set 3
          (i32.add
            (local.get 3)
            (i32.const 64)))
        (br_if 0 (;@2;)
          (i32.lt_u
            (local.get 3)
            (local.get 1))))
      (local.set 2
        (i32.add
          (local.get 2)
          (i32.const 64)))
      (br_if 0 (;@2;)
        (i32.lt_u
          (local.get 2)
          (local.get 1))))
    (call 43
      (local.get 0)))
  (memory (;0;) 4)
  (export "vlen2" (func 0))
  (export "vlen" (func 1))
  (export "vgetx" (func 3))
  (export "vgety" (func 4))
  (export "vgetz" (func 5))
  (export "vsetx" (func 6))
  (export "vsety" (func 7))
  (export "vsetz" (func 8))
  (export "vset" (func 2))
  (export "vadd" (func 9))
  (export "vsub" (func 10))
  (export "vmulkv" (func 11))
  (export "vmulvk" (func 12))
  (export "vdivvk" (func 13))
  (export "vscalar" (func 14))
  (export "vnorm" (func 15))
  (export "vzero" (func 16))
  (export "pInit" (func 17))
  (export "pGetForcePointer" (func 18))
  (export "pGetVelocityPointer" (func 19))
  (export "pGetPositionPointer" (func 20))
  (export "pClearForce" (func 21))
  (export "pAddForce" (func 22))
  (export "pSubForce" (func 23))
  (export "pSetMass" (func 24))
  (export "pGetMass" (func 25))
  (export "pSetRadius" (func 26))
  (export "pGetRadius" (func 27))
  (export "pTick" (func 28))
  (export "wInit" (func 29))
  (export "wGetDt" (func 33))
  (export "wSetDt" (func 32))
  (export "wGetGravityConst" (func 35))
  (export "wSetGravityConst" (func 34))
  (export "wGetStiffnessConst" (func 37))
  (export "wSetStiffnessConst" (func 36))
  (export "wGetViscosityConst" (func 39))
  (export "wSetViscosityConst" (func 38))
  (export "wGetParticlesCount" (func 30))
  (export "wGetParticlePointer" (func 31))
  (export "wNewParticle" (func 40))
  (export "wRemoveParticle" (func 41))
  (export "wClearForces" (func 42))
  (export "wIteratePositions" (func 43))
  (export "wIteratePair" (func 44))
  (export "wIterate" (func 45)))
