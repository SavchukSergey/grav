memory M_a(initial: 4, max: 0);

export function vlen2(a:{ a:float, b:float, c:float }):float {
  return a.a * a.a + a.b * a.b + a.c * a.c
}

export function vlen(a:int):float {
  return sqrt(vlen2(a))
}

export function vset(a:{ a:float, b:float, c:float }, b:float, c:float, d:float) {
  a.a = b;
  a.b = c;
  a.c = d;
}

export function vgetx(a:float_ptr):float {
  return a[0]
}

export function vgety(a:float_ptr):float {
  return a[1]
}

export function vgetz(a:float_ptr):float {
  return a[2]
}

export function vsetx(a:float_ptr, b:float) {
  a[0] = b
}

export function vsety(a:float_ptr, b:float) {
  a[1] = b
}

export function vsetz(a:float_ptr, b:float) {
  a[2] = b
}

export function vadd(a:{ a:float, b:float, c:float }, b:{ a:float, b:float, c:float }, c:{ a:float, b:float, c:float }) {
  a.a = b.a + c.a;
  a.b = b.b + c.b;
  a.c = b.c + c.c;
}

export function vsub(a:{ a:float, b:float, c:float }, b:{ a:float, b:float, c:float }, c:{ a:float, b:float, c:float }) {
  a.a = b.a - c.a;
  a.b = b.b - c.b;
  a.c = b.c - c.c;
}

export function vmulkv(a:{ a:float, b:float, c:float }, b:float, c:{ a:float, b:float, c:float }) {
  a.a = b * c.a;
  a.b = b * c.b;
  a.c = b * c.c;
}

export function vmulvk(a:{ a:float, b:float, c:float }, b:{ a:float, b:float, c:float }, c:float) {
  a.a = c * b.a;
  a.b = c * b.b;
  a.c = c * b.c;
}

export function vdivvk(a:{ a:float, b:float, c:float }, b:{ a:float, b:float, c:float }, c:float) {
  a.a = b.a / c;
  a.b = b.b / c;
  a.c = b.c / c;
}

export function vscalar(a:{ a:float, b:float, c:float }, b:{ a:float, b:float, c:float }):float {
  return a.a * b.a + a.b * b.b + a.c * b.c
}

export function vnorm(a:int, b:int) {
  vdivvk(a, b, vlen(b))
}

export function vzero(a:{ a:float, b:float, c:float }) {
  a.a = 0.0f;
  a.b = 0.0f;
  a.c = 0.0f;
}

export function pInit(a:int) {
  pClearForce(a);
  vzero(pGetVelocityPointer(a));
  vzero(pGetPositionPointer(a));
}

export function pGetForcePointer(a:int):int {
  return a + 32
}

export function pGetVelocityPointer(a:int):int {
  return a + 16
}

export function pGetPositionPointer(a:int):int {
  return a
}

export function pClearForce(a:float_ptr) {
  a[8] = 0.0f;
  a[9] = 0.0f;
  a[10] = 0.0f;
}

export function pAddForce(a:int, b:int) {
  var c:int = a + 32;
  vadd(c, c, b);
}

export function pSubForce(a:int, b:int) {
  var c:int = a + 32;
  vsub(c, c, b);
}

export function pSetMass(a:float_ptr, b:float) {
  a[12] = b
}

export function pGetMass(a:float_ptr):float {
  return a[12]
}

export function pSetRadius(a:float_ptr, b:float) {
  a[13] = b
}

export function pGetRadius(a:float_ptr):float {
  return a[13]
}

export function pTick(a:float_ptr, b:float) {
  var c:int = a + 32;
  var d:int = a + 16;
  vmulvk(0, c, b / a[12]);
  vadd(d, d, 0);
  vmulvk(0, d, b);
  vadd(a, a, 0);
}

export function wInit(a:int_ptr) {
  wSetDt(a, 1.0f);
  wSetGravityConst(a, 0.0f);
  wSetStiffnessConst(a, 1.0f);
  wSetViscosityConst(a, 0.0001f);
  a[4] = 0;
}

export function wGetParticlesCount(a:int_ptr):int {
  return a[4]
}

export function wGetParticlePointer(a:int, b:int):int {
  return 20 + a + (b << 6)
}

export function wSetDt(a:float_ptr, b:float) {
  a[0] = b
}

export function wGetDt(a:float_ptr):float {
  return a[0]
}

export function wSetGravityConst(a:float_ptr, b:float) {
  a[1] = b
}

export function wGetGravityConst(a:float_ptr):float {
  return a[1]
}

export function wSetStiffnessConst(a:float_ptr, b:float) {
  a[2] = b
}

export function wGetStiffnessConst(a:float_ptr):float {
  return a[2]
}

export function wSetViscosityConst(a:float_ptr, b:float) {
  a[3] = b
}

export function wGetViscosityConst(a:float_ptr):float {
  return a[3]
}

export function wNewParticle(a:int_ptr):int {
  var b:int = wGetParticlePointer(a, a[4]);
  a[4] = a[4] + 1;
  pInit(b);
  return b;
}

export function wRemoveParticle(a:int_ptr) {
  a[4] = a[4] - 1
}

export function wClearForces(a:int) {
  var c:int = wGetParticlePointer(a, 0);
  var b:int = wGetParticlePointer(a, wGetParticlesCount(a));
  loop L_a {
    pClearForce(c);
    c = c + 64;
    if (c < b) continue L_a;
  }
}

export function wIteratePositions(a:int) {
  var d:float = wGetDt(a);
  var c:int = wGetParticlePointer(a, 0);
  var b:int = wGetParticlePointer(a, wGetParticlesCount(a));
  loop L_a {
    pTick(c, d);
    c = c + 64;
    if (c < b) continue L_a;
  }
}

export function wIteratePair(a:float_ptr, b:float_ptr, c:float_ptr) {
  vsub(0, pGetPositionPointer(b), pGetPositionPointer(c));
  var d:float = vlen2(0);
  var e:float = sqrt(d);
  vdivvk(16, 0, e);
  var f:float = b[13] + c[13];
  var g:float = a[1] * b[12] * c[12] / d;
  var h:float = f - e;
  if (h >= 0.0f) {
    g = 
      g + 
      (vscalar(16, b + 16) * b[12] - vscalar(16, c + 16) * c[12]) * a[3] - 
      a[2] * h * h * h
  }
  vmulvk(16, 16, g);
  pSubForce(b, 16);
  pAddForce(c, 16);
}

export function wIterate(a:int) {
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

