Shader "CameraFilterPack/FX_Drunk2" {
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
uniform float _TimeX;
uniform sampler2D _MainTex;
void main ()
{
  float tmpvar_1;
  tmpvar_1 = (sin(_TimeX) * 0.05);
  vec2 tmpvar_2;
  tmpvar_2.y = 0.0;
  tmpvar_2.x = sin(tmpvar_1);
  vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = sin(tmpvar_1);
  vec2 tmpvar_4;
  tmpvar_4.x = 0.0;
  tmpvar_4.y = sin(tmpvar_1);
  vec2 tmpvar_5;
  tmpvar_5.x = 0.0;
  tmpvar_5.y = sin(tmpvar_1);
  gl_FragData[0] = (((((texture2D (_MainTex, xlv_TEXCOORD0) + texture2D (_MainTex, (xlv_TEXCOORD0 - tmpvar_2))) + texture2D (_MainTex, (xlv_TEXCOORD0 + tmpvar_3))) + texture2D (_MainTex, (xlv_TEXCOORD0 - tmpvar_4))) + texture2D (_MainTex, (xlv_TEXCOORD0 + tmpvar_5))) / 5.0);
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
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
; 37 ALU, 5 TEX
dcl_2d s0
def c1, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c2, 0.05000000, 0.00000000, 0.20000000, 0
dcl_texcoord0 v0.xy
mov r0.x, c0
mad r0.x, r0, c1, c1.y
frc r0.x, r0
mad r1.x, r0, c1.z, c1.w
sincos r0.xy, r1.x
mul r0.x, r0.y, c2
mad r0.x, r0, c1, c1.y
frc r0.x, r0
mad r0.x, r0, c1.z, c1.w
sincos r3.xy, r0.x
mov r0.y, c2
mov r0.x, r3.y
add r1.xy, v0, r0
add r0.xy, v0, -r0
texld r2, r1, s0
texld r1, r0, s0
texld r0, v0, s0
add r0, r0, r1
add r2, r0, r2
mov r0.w, r3.y
mov r0.z, c2.y
add r1.xy, v0, r0.zwzw
add r0.xy, v0, -r0.zwzw
texld r0, r0, s0
texld r1, r1, s0
add r0, r2, r0
add r0, r0, r1
mul oC0, r0, c2.z
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 16 [_TimeX]
BindCB  "$Globals" 0
"ps_4_0
eefieceddnfpcabampajealcippidjapamcghhinabaaaaaacaadaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaadadaaaafjaaaaaaaaaaaaaaabaaaaaa
adaaaaaaabaaaaaaapaaaaaagfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafeeffiedepepfceeaafdfgfpfaepfdejfeejepeoaaedepemepfcaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefceeacaaaaeaaaaaaa
jbaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaaaaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaenaaaaahbcaabaaaabaaaaaa
aanaaaaaakiacaaaaaaaaaaaabaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaamnmmemdnenaaaaagccaabaaaabaaaaaaaanaaaaaakaabaaa
abaaaaaadgaaaaafbcaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaaipcaabaaa
acaaaaaabgaebaiaebaaaaaaabaaaaaaegbebaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaabgaebaaaabaaaaaaegbebaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
egaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
acaaaaaaogakbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaadaaaaaaefaaaaajpcaabaaa
adaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaadaaaaaaaaaaaaah
pcaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaaaaaaaaaaaaaaaahpcaabaaa
aaaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaadiaaaaakpccabaaaaaaaaaaa
egaobaaaaaaaaaaaaceaaaaamnmmemdomnmmemdomnmmemdomnmmemdodoaaaaab
"
}
}
 }
}
}