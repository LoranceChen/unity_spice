Shader "CameraFilterPack/Oculus_ThermaVision" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _TimeX ("Time", Range(0,1)) = 1
 _ScreenResolution ("_ScreenResolution", Vector) = (0,0,0,0)
}
SubShader { 
 Pass {
  ZTest Always
Program "vp" {
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_COLOR;
varying vec2 xlv_TEXCOORD0;

void main ()
{
  xlv_TEXCOORD0 = gl_MultiTexCoord0.xy;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_COLOR = gl_Color;
}


#endif
#ifdef FRAGMENT
varying vec2 xlv_TEXCOORD0;
uniform float _Value;
uniform sampler2D _MainTex;
void main ()
{
  vec4 thermal_1;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  float tmpvar_3;
  tmpvar_3 = (((tmpvar_2.x + tmpvar_2.y) + tmpvar_2.z) / 3.0);
  if ((tmpvar_3 < _Value)) {
    thermal_1 = mix (vec4(0.0, 0.0, 1.0, 1.0), vec4(1.0, 0.0, 0.0, 1.0), vec4((tmpvar_3 / _Value)));
  };
  if ((tmpvar_3 >= _Value)) {
    thermal_1 = mix (vec4(1.0, 1.0, 0.0, 1.0), vec4(1.0, 0.0, 0.0, 1.0), vec4(((tmpvar_3 - _Value) / _Value)));
  };
  gl_FragData[0] = thermal_1;
}


#endif
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
; 6 ALU
dcl_texcoord0 o0
dcl_position o1
dcl_color0 o2
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov o2, v1
mov o0.xy, v2
dp4 o1.w, v0, c3
dp4 o1.z, v0, c2
dp4 o1.y, v0, c1
dp4 o1.x, v0, c0
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0
eefiecedminmaehajkdlbmjdcohoiklgjajckplgabaaaaaaeiacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
adamaaaafjaaaaaaaaaaaaaaabaaaaaaadaaaaaaabaaaaaaapaaaaaagfaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafeeffiedepepfceeaafdfgfp
faepfdejfeejepeoaaedepemepfcaaklfdeieefcdaabaaaaeaaaabaaemaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaagfaaaaaddccabaaaaaaaaaaa
ghaaaaaepccabaaaabaaaaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaac
abaaaaaadgaaaaafdccabaaaaaaaaaaaegbabaaaacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaabaaaaaaegiocaaaaaaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaaegbobaaa
abaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
Float 0 [_Value]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
; 11 ALU, 1 TEX
dcl_2d s0
def c1, 0.33333334, 1.00000000, 0.00000000, -1.00000000
dcl_texcoord0 v0.xy
texld r1.xyz, v0, s0
add r1.x, r1, r1.y
add r1.x, r1, r1.z
mul r1.x, r1, c1
rcp r2.y, c0.x
add r2.x, r1, -c0
mul r1.y, r1.x, r2
mad r1, r1.y, c1.yzwz, c1.zzyy
cmp r0, r2.x, r0, r1
mul r2.y, r2.x, r2
mad r1.xyz, r2.y, c1.zwzw, -c1.wwzw
cmp oC0, r2.x, r1.xyzx, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 20 [_Value]
BindCB  "$Globals" 0
"ps_4_0
eefiecedijodkpdhinmnjgcfdmdigdkhebkmamloabaaaaaaneacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaadadaaaafjaaaaaaaaaaaaaaabaaaaaa
adaaaaaaabaaaaaaapaaaaaagfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafeeffiedepepfceeaafdfgfpfaepfdejfeejepeoaaedepemepfcaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpiabaaaaeaaaaaaa
hoaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaaaaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaalccaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaklkkkkdobkiacaiaebaaaaaaaaaaaaaaabaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaklkkkkdoaoaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkiacaaaaaaaaaaaabaaaaaadcaaaaappcaabaaaabaaaaaa
fgafbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaiadpaoaaaaaiccaabaaaaaaaaaaaakaabaaa
aaaaaaaabkiacaaaaaaaaaaaabaaaaaabnaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkiacaaaaaaaaaaaabaaaaaadcaaaaappcaabaaaacaaaaaafgafbaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaialpaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaiadpaaaaiadpdhaaaaajpccabaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaaegaobaaaacaaaaaadoaaaaab"
}
}
 }
}
}