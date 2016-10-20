Shader "CameraFilterPack/TV_Chromatical2" {
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
uniform float _TimeX;
uniform sampler2D _MainTex;
void main ()
{
  vec3 col_1;
  vec2 tmpvar_2;
  tmpvar_2 = (0.5 + ((xlv_TEXCOORD0 - 0.5) * (0.9 + (0.1 * sin((0.2 * _TimeX))))));
  vec3 tmpvar_3;
  tmpvar_3 = (vec3(0.019, 0.0, -0.019) * (abs((tmpvar_2.x - 0.5)) * _Value));
  vec2 tmpvar_4;
  tmpvar_4.x = (tmpvar_2.x + tmpvar_3.x);
  tmpvar_4.y = tmpvar_2.y;
  col_1.x = texture2D (_MainTex, tmpvar_4).x;
  vec2 tmpvar_5;
  tmpvar_5.x = (tmpvar_2.x + tmpvar_3.y);
  tmpvar_5.y = tmpvar_2.y;
  col_1.y = texture2D (_MainTex, tmpvar_5).y;
  vec2 tmpvar_6;
  tmpvar_6.x = (tmpvar_2.x + tmpvar_3.z);
  tmpvar_6.y = tmpvar_2.y;
  col_1.z = texture2D (_MainTex, tmpvar_6).z;
  vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = col_1;
  gl_FragData[0] = tmpvar_7;
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
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
; 25 ALU, 3 TEX
dcl_2d s0
def c2, 0.03183098, 0.50000000, 6.28318501, -3.14159298
def c3, -0.50000000, 0.10000000, 0.89999998, -0.01900000
def c4, 0.00000000, 0.01900000, 1.00000000, 0
dcl_texcoord0 v0.xy
mov r0.x, c0
mad r0.x, r0, c2, c2.y
frc r0.x, r0
mad r1.x, r0, c2.z, c2.w
sincos r0.xy, r1.x
mad r0.z, r0.y, c3.y, c3
add r0.xy, v0, c3.x
mul r0.xy, r0, r0.z
add r0.zw, r0.xyxy, c2.y
abs r1.x, r0
mul r1.x, r1, c1
mov r0.y, r0.w
mad r0.x, r1, c4.y, r0.z
texld oC0.x, r0, s0
mov r0.y, r0.w
mad r0.x, r1, c4, r0.z
texld oC0.y, r0, s0
mov r0.y, r0.w
mad r0.x, r1, c3.w, r0.z
texld oC0.z, r0, s0
mov oC0.w, c4.z
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 16 [_TimeX]
Float 20 [_Value]
BindCB  "$Globals" 0
"ps_4_0
eefiecedlmmfcikonhijdlmecdmfooendbojpldpabaaaaaabeadaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaadadaaaafjaaaaaaaaaaaaaaabaaaaaa
adaaaaaaabaaaaaaapaaaaaagfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafeeffiedepepfceeaafdfgfpfaepfdejfeejepeoaaedepemepfcaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdiacaaaaeaaaaaaa
ioaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaaaaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaadiaaaaaibcaabaaaaaaaaaaaakiacaaa
aaaaaaaaabaaaaaaabeaaaaamnmmemdoenaaaaagbcaabaaaaaaaaaaaaanaaaaa
akaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
mnmmmmdnabeaaaaaggggggdpaaaaaaakgcaabaaaaaaaaaaaagbbbaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaalpaaaaaalpaaaaaaaadiaaaaahicaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaammcaabaaaabaaaaaafgajbaaa
aaaaaaaaagaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadp
diaaaaajbcaabaaaaaaaaaaadkaabaiaibaaaaaaaaaaaaaabkiacaaaaaaaaaaa
abaaaaaadcaaaaamdcaabaaaabaaaaaaagaabaaaaaaaaaaaaceaaaaaodkfjldm
odkfjllmaaaaaaaaaaaaaaaakgakbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaa
mgaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
acaaaaaangafbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dgaaaaafcccabaaaaaaaaaaabkaabaaaabaaaaaadgaaaaafeccabaaaaaaaaaaa
ckaabaaaacaaaaaadgaaaaafbccabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
}
 }
}
}