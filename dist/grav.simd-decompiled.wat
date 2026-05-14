(module
  (type (;0;) (func (param i32) (result f32)))
  (type (;1;) (func (param v128) (result f32)))
  (type (;2;) (func (param i32 f32 f32 f32)))
  (type (;3;) (func (param i32 f32)))
  (type (;4;) (func (param i32 i32 i32)))
  (type (;5;) (func (param i32 f32 i32)))
  (type (;6;) (func (param i32 i32 f32)))
  (type (;7;) (func (param i32 i32) (result f32)))
  (type (;8;) (func (param v128 v128) (result f32)))
  (type (;9;) (func (param i32 i32)))
  (type (;10;) (func (param i32)))
  (type (;11;) (func (param i32) (result i32)))
  (type (;12;) (func (param i32 i32) (result i32)))
  (func (;0;) (type 0) (param i32) (result f32)
    (local v128)
    (local.set 1
      (f32x4.mul
        (v128.load
          (local.get 0))
        (v128.load
          (local.get 0))))
    (f32.add
      (f32.add
        (f32x4.extract_lane 0
          (local.get 1))
        (f32x4.extract_lane 1
          (local.get 1)))
      (f32x4.extract_lane 2
        (local.get 1))))
  (func (;1;) (type 1) (param v128) (result f32)
    (local v128)
    (local.set 1
      (f32x4.mul
        (local.get 0)
        (local.get 0)))
    (f32.add
      (f32.add
        (f32x4.extract_lane 0
          (local.get 1))
        (f32x4.extract_lane 1
          (local.get 1)))
      (f32x4.extract_lane 2
        (local.get 1))))
  (func (;2;) (type 0) (param i32) (result f32)
    (f32.sqrt
      (call 1
        (v128.load
          (local.get 0)))))
  (func (;3;) (type 1) (param v128) (result f32)
    (f32.sqrt
      (call 1
        (local.get 0))))
  (func (;4;) (type 2) (param i32 f32 f32 f32)
    (f32.store
      (local.get 0)
      (local.get 1))
    (f32.store offset=4
      (local.get 0)
      (local.get 2))
    (f32.store offset=8
      (local.get 0)
      (local.get 3)))
  (func (;5;) (type 0) (param i32) (result f32)
    (f32.load
      (local.get 0)))
  (func (;6;) (type 0) (param i32) (result f32)
    (f32.load offset=4
      (local.get 0)))
  (func (;7;) (type 0) (param i32) (result f32)
    (f32.load offset=8
      (local.get 0)))
  (func (;8;) (type 3) (param i32 f32)
    (f32.store
      (local.get 0)
      (local.get 1)))
  (func (;9;) (type 3) (param i32 f32)
    (f32.store offset=4
      (local.get 0)
      (local.get 1)))
  (func (;10;) (type 3) (param i32 f32)
    (f32.store offset=8
      (local.get 0)
      (local.get 1)))
  (func (;11;) (type 4) (param i32 i32 i32)
    (v128.store
      (local.get 0)
      (f32x4.add
        (v128.load
          (local.get 1))
        (v128.load
          (local.get 2)))))
  (func (;12;) (type 4) (param i32 i32 i32)
    (v128.store
      (local.get 0)
      (f32x4.sub
        (v128.load
          (local.get 1))
        (v128.load
          (local.get 2)))))
  (func (;13;) (type 5) (param i32 f32 i32)
    (v128.store
      (local.get 0)
      (f32x4.mul
        (v128.load
          (local.get 2))
        (f32x4.splat
          (local.get 1)))))
  (func (;14;) (type 6) (param i32 i32 f32)
    (v128.store
      (local.get 0)
      (f32x4.mul
        (v128.load
          (local.get 1))
        (f32x4.splat
          (local.get 2)))))
  (func (;15;) (type 6) (param i32 i32 f32)
    (v128.store
      (local.get 0)
      (f32x4.div
        (v128.load
          (local.get 1))
        (f32x4.splat
          (local.get 2)))))
  (func (;16;) (type 7) (param i32 i32) (result f32)
    (local v128)
    (local.set 2
      (f32x4.mul
        (v128.load
          (local.get 0))
        (v128.load
          (local.get 1))))
    (f32.add
      (f32.add
        (f32x4.extract_lane 0
          (local.get 2))
        (f32x4.extract_lane 1
          (local.get 2)))
      (f32x4.extract_lane 2
        (local.get 2))))
  (func (;17;) (type 8) (param v128 v128) (result f32)
    (local v128)
    (local.set 2
      (f32x4.mul
        (local.get 0)
        (local.get 1)))
    (f32.add
      (f32.add
        (f32x4.extract_lane 0
          (local.get 2))
        (f32x4.extract_lane 1
          (local.get 2)))
      (f32x4.extract_lane 2
        (local.get 2))))
  (func (;18;) (type 9) (param i32 i32)
    (call 15
      (local.get 0)
      (local.get 1)
      (call 2
        (local.get 1))))
  (func (;19;) (type 10) (param i32)
    (f32.store
      (local.get 0)
      (f32.const 0x0p+0 (;=0;)))
    (f32.store offset=4
      (local.get 0)
      (f32.const 0x0p+0 (;=0;)))
    (f32.store offset=8
      (local.get 0)
      (f32.const 0x0p+0 (;=0;))))
  (func (;20;) (type 10) (param i32)
    (call 24
      (local.get 0))
    (call 19
      (call 22
        (local.get 0)))
    (call 19
      (call 23
        (local.get 0))))
  (func (;21;) (type 11) (param i32) (result i32)
    (i32.add
      (local.get 0)
      (i32.const 32)))
  (func (;22;) (type 11) (param i32) (result i32)
    (i32.add
      (local.get 0)
      (i32.const 16)))
  (func (;23;) (type 11) (param i32) (result i32)
    (local.get 0))
  (func (;24;) (type 10) (param i32)
    (v128.store offset=32
      (local.get 0)
      (v128.const i32x4 0x00000000 0x00000000 0x00000000 0x00000000)))
  (func (;25;) (type 9) (param i32 i32)
    (v128.store offset=32
      (local.get 0)
      (f32x4.add
        (v128.load offset=32
          (local.get 0))
        (v128.load
          (local.get 1)))))
  (func (;26;) (type 9) (param i32 i32)
    (v128.store offset=32
      (local.get 0)
      (f32x4.sub
        (v128.load offset=32
          (local.get 0))
        (v128.load
          (local.get 1)))))
  (func (;27;) (type 3) (param i32 f32)
    (f32.store offset=48
      (local.get 0)
      (local.get 1)))
  (func (;28;) (type 0) (param i32) (result f32)
    (f32.load offset=48
      (local.get 0)))
  (func (;29;) (type 3) (param i32 f32)
    (f32.store offset=52
      (local.get 0)
      (local.get 1)))
  (func (;30;) (type 0) (param i32) (result f32)
    (f32.load offset=52
      (local.get 0)))
  (func (;31;) (type 3) (param i32 f32)
    (v128.store offset=16
      (local.get 0)
      (f32x4.add
        (v128.load offset=16
          (local.get 0))
        (f32x4.mul
          (v128.load offset=32
            (local.get 0))
          (f32x4.splat
            (f32.div
              (local.get 1)
              (f32.load offset=48
                (local.get 0)))))))
    (v128.store
      (local.get 0)
      (f32x4.add
        (v128.load
          (local.get 0))
        (f32x4.mul
          (v128.load offset=16
            (local.get 0))
          (f32x4.splat
            (local.get 1))))))
  (func (;32;) (type 10) (param i32)
    (call 35
      (local.get 0)
      (f32.const 0x1p+0 (;=1;)))
    (call 37
      (local.get 0)
      (f32.const 0x1.255986p-34 (;=6.67e-11;)))
    (call 39
      (local.get 0)
      (f32.const 0x1p+0 (;=1;)))
    (call 41
      (local.get 0)
      (f32.const 0x1.a36e2ep-14 (;=0.0001;)))
    (i32.store offset=16
      (local.get 0)
      (i32.const 0)))
  (func (;33;) (type 11) (param i32) (result i32)
    (i32.load offset=16
      (local.get 0)))
  (func (;34;) (type 12) (param i32 i32) (result i32)
    (i32.add
      (i32.const 20)
      (i32.add
        (local.get 0)
        (i32.shl
          (local.get 1)
          (i32.const 6)))))
  (func (;35;) (type 3) (param i32 f32)
    (f32.store
      (local.get 0)
      (local.get 1)))
  (func (;36;) (type 0) (param i32) (result f32)
    (f32.load
      (local.get 0)))
  (func (;37;) (type 3) (param i32 f32)
    (f32.store offset=4
      (local.get 0)
      (local.get 1)))
  (func (;38;) (type 0) (param i32) (result f32)
    (f32.load offset=4
      (local.get 0)))
  (func (;39;) (type 3) (param i32 f32)
    (f32.store offset=8
      (local.get 0)
      (local.get 1)))
  (func (;40;) (type 0) (param i32) (result f32)
    (f32.load offset=8
      (local.get 0)))
  (func (;41;) (type 3) (param i32 f32)
    (f32.store offset=12
      (local.get 0)
      (local.get 1)))
  (func (;42;) (type 0) (param i32) (result f32)
    (f32.load offset=12
      (local.get 0)))
  (func (;43;) (type 11) (param i32) (result i32)
    (local i32)
    (local.set 1
      (call 34
        (local.get 0)
        (i32.load offset=16
          (local.get 0))))
    (i32.store offset=16
      (local.get 0)
      (i32.add
        (i32.load offset=16
          (local.get 0))
        (i32.const 1)))
    (call 20
      (local.get 1))
    (local.get 1))
  (func (;44;) (type 10) (param i32)
    (i32.store offset=16
      (local.get 0)
      (i32.sub
        (i32.load offset=16
          (local.get 0))
        (i32.const 1))))
  (func (;45;) (type 10) (param i32)
    (local i32 i32)
    (local.set 2
      (call 34
        (local.get 0)
        (i32.const 0)))
    (local.set 1
      (call 34
        (local.get 0)
        (call 33
          (local.get 0))))
    (loop  ;; label = @1
      (call 24
        (local.get 2))
      (local.set 2
        (i32.add
          (local.get 2)
          (i32.const 64)))
      (br_if 0 (;@1;)
        (i32.lt_u
          (local.get 2)
          (local.get 1)))))
  (func (;46;) (type 10) (param i32)
    (local i32 i32 f32)
    (local.set 3
      (call 36
        (local.get 0)))
    (local.set 2
      (call 34
        (local.get 0)
        (i32.const 0)))
    (local.set 1
      (call 34
        (local.get 0)
        (call 33
          (local.get 0))))
    (loop  ;; label = @1
      (call 31
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
  (func (;47;) (type 4) (param i32 i32 i32)
    (local f32 f32 f32 f32 v128 f32 v128 v128)
    (local.set 9
      (f32x4.sub
        (v128.load
          (local.get 1))
        (v128.load
          (local.get 2))))
    (local.set 4
      (f32.sqrt
        (local.tee 3
          (call 1
            (local.get 9)))))
    (local.set 10
      (f32x4.div
        (local.get 9)
        (f32x4.splat
          (local.get 4))))
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
    (local.set 8
      (f32.sub
        (local.get 5)
        (local.get 4)))
    (if  ;; label = @1
      (f32.ge
        (local.get 8)
        (f32.const 0x0p+0 (;=0;)))
      (then
        (local.set 6
          (f32.add
            (local.get 6)
            (f32.sub
              (f32.mul
                (f32.sub
                  (f32.mul
                    (call 17
                      (local.get 10)
                      (v128.load offset=16
                        (local.get 1)))
                    (f32.load offset=48
                      (local.get 1)))
                  (f32.mul
                    (call 17
                      (local.get 10)
                      (v128.load offset=16
                        (local.get 2)))
                    (f32.load offset=48
                      (local.get 2))))
                (f32.load offset=12
                  (local.get 0)))
              (f32.mul
                (f32.load offset=8
                  (local.get 0))
                (f32.mul
                  (f32.mul
                    (local.get 8)
                    (local.get 8))
                  (local.get 8))))))))
    (local.set 7
      (f32x4.mul
        (local.get 10)
        (f32x4.splat
          (local.get 6))))
    (v128.store offset=32
      (local.get 1)
      (f32x4.sub
        (v128.load offset=32
          (local.get 1))
        (local.get 7)))
    (v128.store offset=32
      (local.get 2)
      (f32x4.add
        (v128.load offset=32
          (local.get 2))
        (local.get 7))))
  (func (;48;) (type 10) (param i32)
    (local i32 i32 i32)
    (call 45
      (local.get 0))
    (local.set 2
      (call 34
        (local.get 0)
        (i32.const 0)))
    (local.set 1
      (call 34
        (local.get 0)
        (call 33
          (local.get 0))))
    (loop  ;; label = @1
      (local.set 3
        (i32.add
          (local.get 2)
          (i32.const 64)))
      (loop  ;; label = @2
        (call 47
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
      (br_if 0 (;@1;)
        (i32.lt_u
          (local.get 2)
          (local.get 1))))
    (call 46
      (local.get 0)))
  (memory (;0;) 4)
  (export "vlen2" (func 0))
  (export "vlen" (func 2))
  (export "vgetx" (func 5))
  (export "vgety" (func 6))
  (export "vgetz" (func 7))
  (export "vsetx" (func 8))
  (export "vsety" (func 9))
  (export "vsetz" (func 10))
  (export "vset" (func 4))
  (export "vadd" (func 11))
  (export "vsub" (func 12))
  (export "vmulkv" (func 13))
  (export "vmulvk" (func 14))
  (export "vdivvk" (func 15))
  (export "vscalar" (func 16))
  (export "vnorm" (func 18))
  (export "vzero" (func 19))
  (export "pInit" (func 20))
  (export "pGetForcePointer" (func 21))
  (export "pGetVelocityPointer" (func 22))
  (export "pGetPositionPointer" (func 23))
  (export "pClearForce" (func 24))
  (export "pAddForce" (func 25))
  (export "pSubForce" (func 26))
  (export "pSetMass" (func 27))
  (export "pGetMass" (func 28))
  (export "pSetRadius" (func 29))
  (export "pGetRadius" (func 30))
  (export "pTick" (func 31))
  (export "wInit" (func 32))
  (export "wGetDt" (func 36))
  (export "wSetDt" (func 35))
  (export "wGetGravityConst" (func 38))
  (export "wSetGravityConst" (func 37))
  (export "wGetStiffnessConst" (func 40))
  (export "wSetStiffnessConst" (func 39))
  (export "wGetViscosityConst" (func 42))
  (export "wSetViscosityConst" (func 41))
  (export "wGetParticlesCount" (func 33))
  (export "wGetParticlePointer" (func 34))
  (export "wNewParticle" (func 43))
  (export "wRemoveParticle" (func 44))
  (export "wClearForces" (func 45))
  (export "wIteratePositions" (func 46))
  (export "wIteratePair" (func 47))
  (export "wIterate" (func 48)))
