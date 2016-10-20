Shader "CameraFilterPack/FX_Screens" {
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
uniform float _Value4;
uniform float _Value3;
uniform float _Value2;
uniform float _Value;
uniform float _TimeX;
uniform sampler2D _MainTex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, (floor((xlv_TEXCOORD0 * _Value)) / _Value));
  float x_2;
  x_2 = (((tmpvar_1.x + tmpvar_1.y) + tmpvar_1.z) + (_TimeX * _Value2));
  float tmpvar_3;
  float x_4;
  x_4 = (xlv_TEXCOORD0 * _Value).x;
  tmpvar_3 = (x_4 - floor(x_4));
  vec2 tmpvar_5;
  tmpvar_5.x = pow ((tmpvar_3 - 0.5), 2.0);
  tmpvar_5.y = pow ((tmpvar_3 - 0.5), 2.0);
  vec2 tmpvar_6;
  tmpvar_6.x = _Value3;
  tmpvar_6.y = _Value4;
  vec2 tmpvar_7;
  tmpvar_7 = (tmpvar_5 - tmpvar_6);
  gl_FragData[0] = ((vec4(0.7, 1.6, 2.8, 1.0) * (min (max ((((1.0 - (x_2 - floor(x_2))) * 3.0) - 1.8), 0.1), 2.0) * (1.0 - pow (min (1.0, (12.0 * dot (tmpvar_7, tmpvar_7))), 2.0)))) + texture2D (_MainTex, xlv_TEXCOORD0));
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
Float 0 [_TimeX]
Float 1 [_Value]
Float 2 [_Value2]
Float 3 [_Value3]
Float 4 [_Value4]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
; 26 ALU, 2 TEX
dcl_2d s0
def c5, 1.00000000, 3.00000000, -1.79999995, 0.10000000
def c6, 2.00000000, -0.50000000, 12.00000000, 0
def c7, 0.69999999, 1.60000002, 2.79999995, 1.00000000
dcl_texcoord0 v0.xy
mul r0.xy, v0, c1.x
frc r1.xy, r0
add r0.w, r1.x, c6.y
add r0.xy, r0, -r1
rcp r0.z, c1.x
mul r0.xy, r0, r0.z
texld r0.xyz, r0, s0
add r0.x, r0, r0.y
add r0.x, r0, r0.z
mov r0.y, c0.x
mad r0.z, c2.x, r0.y, r0.x
mul r0.w, r0, r0
mov r0.y, c4.x
mov r0.x, c3
add r1.xy, r0.w, -r0
frc r0.x, r0.z
mul r0.zw, r1.xyxy, r1.xyxy
add r0.y, r0.z, r0.w
add r0.x, -r0, c5
mad r0.x, r0, c5.y, c5.z
max r0.x, r0, c5.w
mul r0.y, r0, c6.z
min r0.y, r0, c5.x
min r1.x, r0, c6
mad r1.y, -r0, r0, c5.x
texld r0, v0, s0
mul r1.x, r1, r1.y
mad oC0, r1.x, c7, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 16 [_TimeX]
Float 20 [_Value]
Float 24 [_Value2]
Float 28 [_Value3]
Float 32 [_Value4]
BindCB  "$Globals" 0
"ps_4_0
eefiecedgeoiaodoiadhkapkemkjlafdgjbopmnmabaaaaaafaaeaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaadadaaaafjaaaaaaaaaaaaaaabaaaaaa
adaaaaaaabaaaaaaapaaaaaagfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafeeffiedepepfceeaafdfgfpfaepfdejfeejepeoaaedepemepfcaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcheadaaaaeaaaaaaa
nnaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaaaaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaadiaaaaaidcaabaaaaaaaaaaaegbabaaa
aaaaaaaafgifcaaaaaaaaaaaabaaaaaaebaaaaafdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaoaaaaaigcaabaaaaaaaaaaaagabbaaaaaaaaaaafgifcaaaaaaaaaaa
abaaaaaadcaaaaalbcaabaaaaaaaaaaaakbabaaaaaaaaaaabkiacaaaaaaaaaaa
abaaaaaaakaabaiaebaaaaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaalpefaaaaajpcaabaaaabaaaaaajgafbaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaa
abaaaaaaakaabaaaabaaaaaaaaaaaaahccaabaaaaaaaaaaackaabaaaabaaaaaa
bkaabaaaaaaaaaaadcaaaaalccaabaaaaaaaaaaaakiacaaaaaaaaaaaabaaaaaa
ckiacaaaaaaaaaaaabaaaaaabkaabaaaaaaaaaaaebaaaaafecaabaaaaaaaaaaa
bkaabaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
bkaabaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaeaeaabeaaaaaggggoglpdeaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaamnmmmmdnddaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaaaeadgaaaaahbcaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaabaaaaaa
dgaaaaahccaabaaaabaaaaaaakiacaiaebaaaaaaaaaaaaaaacaaaaaadcaaaaaj
fcaabaaaaaaaaaaaagaabaaaaaaaaaaaagaabaaaaaaaaaaaagabbaaaabaaaaaa
apaaaaahbcaabaaaaaaaaaaaigaabaaaaaaaaaaaigaabaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaeaebddaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaakbcaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
pccabaaaaaaaaaaaagaabaaaaaaaaaaaaceaaaaadddddddpmnmmmmdpddddddea
aaaaiadpegaobaaaabaaaaaadoaaaaab"
}
}
 }
}
}