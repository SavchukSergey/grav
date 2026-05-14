memory M_a(initial: 4, max: 0);

export function vlen2(a:simd_ptr):float { // func0
  var b:simd = a[0] f32x4_mul a[0];
  return SimdLaneOp(b) + SimdLaneOp(b) + SimdLaneOp(b);
}

function f_b(a:simd):float { // func1
  var b:simd = a f32x4_mul a;
  return SimdLaneOp(b) + SimdLaneOp(b) + SimdLaneOp(b);
}

export function vlen(a:simd_ptr):float { // func2
  return sqrt(f_b(a[0]))
}

function f_d(a:simd):float { // func3
  return sqrt(f_b(a))
}

export function vset(a:{ a:float, b:float, c:float }, b:float, c:float, d:float) { // func4
  a.a = b;
  a.b = c;
  a.c = d;
}

export function vgetx(a:float_ptr):float { // func5
  return a[0]
}

export function vgety(a:float_ptr):float { // func6
  return a[1]
}

export function vgetz(a:float_ptr):float { // func7
  return a[2]
}

export function vsetx(a:float_ptr, b:float) { // func8
  a[0] = b
}

export function vsety(a:float_ptr, b:float) { // func9
  a[1] = b
}

export function vsetz(a:float_ptr, b:float) { // func10
  a[2] = b
}

export function vadd(a:simd_ptr, b:simd_ptr, c:simd_ptr) { // func11
  a[0] = b[0] f32x4_add c[0]
}

export function vsub(a:simd_ptr, b:simd_ptr, c:simd_ptr) { // func12
  a[0] = b[0] f32x4_sub c[0]
}

export function vmulkv(a:simd_ptr, b:float, c:simd_ptr) { // func13
  a[0] = c[0] f32x4_mul f32x4_splat(b)
}

export function vmulvk(a:simd_ptr, b:simd_ptr, c:float) { // func14
  a[0] = b[0] f32x4_mul f32x4_splat(c)
}

export function vdivvk(a:simd_ptr, b:simd_ptr, c:float) { // func15
  a[0] = b[0] f32x4_div f32x4_splat(c)
}

export function vscalar(a:simd_ptr, b:simd_ptr):float { // func16
  var c:simd = a[0] f32x4_mul b[0];
  return SimdLaneOp(c) + SimdLaneOp(c) + SimdLaneOp(c);
}

function f_r(a:simd, b:simd):float { // func17
  var c:simd = a f32x4_mul b;
  return SimdLaneOp(c) + SimdLaneOp(c) + SimdLaneOp(c);
}

export function vnorm(a:int, b:int) { // func18
  vdivvk(a, b, vlen(b))
}

export function vzero(a:{ a:float, b:float, c:float }) { // func19
  a.a = 0.0f;
  a.b = 0.0f;
  a.c = 0.0f;
}

export function pInit(a:int) { // func20
  pClearForce(a);
  vzero(pGetVelocityPointer(a));
  vzero(pGetPositionPointer(a));
}

export function pGetForcePointer(a:int):int { // func21
  return a + 32
}

export function pGetVelocityPointer(a:int):int { // func22
  return a + 16
}

export function pGetPositionPointer(a:int):int { // func23
  return a
}

export function pClearForce(a:simd_ptr) { // func24
  a[2] = V128
}

export function pAddForce(a:simd_ptr, b:simd_ptr) { // func25
  a[2] = a[2] f32x4_add b[0]
}

export function pSubForce(a:simd_ptr, b:simd_ptr) { // func26
  a[2] = a[2] f32x4_sub b[0]
}

export function pSetMass(a:float_ptr, b:float) { // func27
  a[12] = b
}

export function pGetMass(a:float_ptr):float { // func28
  return a[12]
}

export function pSetRadius(a:float_ptr, b:float) { // func29
  a[13] = b
}

export function pGetRadius(a:float_ptr):float { // func30
  return a[13]
}

export function pTick(a:{ a:simd, b:simd, c:simd, d:float }, b:float) { // func31
  a.b = a.b f32x4_add (a.c f32x4_mul f32x4_splat(b / a.d));
  a.a = a.a f32x4_add (a.b f32x4_mul f32x4_splat(b));
}

export function wInit(a:int_ptr) { // func32
  wSetDt(a, 1.0f);
  wSetGravityConst(a, 0.0f);
  wSetStiffnessConst(a, 1.0f);
  wSetViscosityConst(a, 0.0001f);
  a[4] = 0;
}

export function wGetParticlesCount(a:int_ptr):int { // func33
  return a[4]
}

export function wGetParticlePointer(a:int, b:int):int { // func34
  return 20 + a + (b << 6)
}

export function wSetDt(a:float_ptr, b:float) { // func35
  a[0] = b
}

export function wGetDt(a:float_ptr):float { // func36
  return a[0]
}

export function wSetGravityConst(a:float_ptr, b:float) { // func37
  a[1] = b
}

export function wGetGravityConst(a:float_ptr):float { // func38
  return a[1]
}

export function wSetStiffnessConst(a:float_ptr, b:float) { // func39
  a[2] = b
}

export function wGetStiffnessConst(a:float_ptr):float { // func40
  return a[2]
}

export function wSetViscosityConst(a:float_ptr, b:float) { // func41
  a[3] = b
}

export function wGetViscosityConst(a:float_ptr):float { // func42
  return a[3]
}

export function wNewParticle(a:int_ptr):int { // func43
  var b:int = wGetParticlePointer(a, a[4]);
  a[4] = a[4] + 1;
  pInit(b);
  return b;
}

export function wRemoveParticle(a:int_ptr) { // func44
  a[4] = a[4] - 1
}

export function wClearForces(a:int) { // func45
  var c:int = wGetParticlePointer(a, 0);
  var b:int = wGetParticlePointer(a, wGetParticlesCount(a));
  loop L_a {
    pClearForce(c);
    c = c + 64;
    if (c < b) continue L_a;
  }
}

export function wIteratePositions(a:int) { // func46
  var d:float = wGetDt(a);
  var c:int = wGetParticlePointer(a, 0);
  var b:int = wGetParticlePointer(a, wGetParticlesCount(a));
  loop L_a {
    pTick(c, d);
    c = c + 64;
    if (c < b) continue L_a;
  }
}

export function wIteratePair(a:float_ptr, b:{ a:simd, b:simd, c:simd, d:float, e:float }, c:{ a:simd, b:simd, c:simd, d:float, e:float }) { // func47
  var j:simd = b.a f32x4_sub c.a;
  var d:float = f_b(j);
  var e:float = sqrt(d);
  var k:simd = j f32x4_div f32x4_splat(e);
  var f:float = b.e + c.e;
  var g:float = a[1] * b.d * c.d / d;
  var i:float = f - e;
  if (i >= 0.0f) {
    g = 
      g + (f_r(k, b.b) * b.d - f_r(k, c.b) * c.d) * a[3] - a[2] * i * i * i
  }
  var h:simd = k f32x4_mul f32x4_splat(g);
  b.c = b.c f32x4_sub h;
  c.c = c.c f32x4_add h;
}

export function wIterate(a:int) { // func48
  wClearForces(a);
  var c:int = wGetParticlePointer(a, 0);
  var b:int = wGetParticlePointer(a, wGetParticlesCount(a));
  loop L_a {
    var d:int = c + 64;
    loop L_b {
      wIteratePair(a, c, d);
      d = d + 64;
      if (d < b) continue L_b;
    }
    c = c + 64;
    if (c < b) continue L_a;
  }
  wIteratePositions(a);
}

