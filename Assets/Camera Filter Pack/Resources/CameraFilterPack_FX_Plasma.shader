Shader "CameraFilterPack/FX_Plasma" {
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
  tmpvar_1 = (1000.0 + (sin((_TimeX * 0.11)) * 20.0));
  float tmpvar_2;
  tmpvar_2 = (800.0 + (sin((_TimeX * 0.15)) * 22.0));
  vec2 tmpvar_3;
  tmpvar_3.x = (sin((xlv_TEXCOORD0.x + (tmpvar_1 * 0.005))) * cos((tmpvar_1 * 0.01)));
  tmpvar_3.y = (cos((xlv_TEXCOORD0.y + (tmpvar_1 * 0.001))) * cos((tmpvar_1 * 0.02)));
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, (tmpvar_3 * 5.0));
  vec2 tmpvar_5;
  tmpvar_5.x = sin((xlv_TEXCOORD0.x + (tmpvar_1 * 0.001)));
  tmpvar_5.y = cos((xlv_TEXCOORD0.y + (tmpvar_1 * 0.005)));
  vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  vec4 tmpvar_7;
  tmpvar_7.xw = vec2(0.0, 1.0);
  tmpvar_7.y = (((((tmpvar_4.x * sin((tmpvar_1 * (sin((xlv_TEXCOORD0.y * 0.5)) + (0.01 * sin(((xlv_TEXCOORD0.x * 5.0) + tmpvar_2))))))) * sin((((((tmpvar_1 * 0.1) * tmpvar_6.x) * (xlv_TEXCOORD0.x - sin((tmpvar_2 * 0.05)))) * sin(((xlv_TEXCOORD0.y - sin((tmpvar_1 * 0.035))) * 5.0))) + sin((0.1 * tmpvar_2))))) * 0.5) + ((tmpvar_6.x * abs(sin(((tmpvar_1 * (xlv_TEXCOORD0.x - 0.5)) * sin((xlv_TEXCOORD0.y + 0.5)))))) * 0.5)) + ((tmpvar_4.x * sin((((tmpvar_1 * (xlv_TEXCOORD0.x - sin((tmpvar_1 * 0.1)))) * sin((xlv_TEXCOORD0.y - sin((tmpvar_1 * 0.1))))) * 0.2))) * 0.1));
  tmpvar_7.z = (((((tmpvar_4.x * sin((tmpvar_2 * (sin((xlv_TEXCOORD0.y * 0.25)) + (0.01 * sin(((xlv_TEXCOORD0.x * 3.0) + tmpvar_2))))))) * abs(sin((((((tmpvar_1 * 0.09) * tmpvar_6.x) * (xlv_TEXCOORD0.x - sin((tmpvar_2 * 0.04)))) * sin(((xlv_TEXCOORD0.y - sin((tmpvar_1 * 0.035))) * 5.0))) + sin((0.1 * tmpvar_2)))))) * 0.5) + ((tmpvar_6.x * abs(sin(((tmpvar_1 * (xlv_TEXCOORD0.x - 0.5)) * sin((xlv_TEXCOORD0.y + 0.5)))))) * 0.5)) + ((tmpvar_4.x * abs(sin((((tmpvar_1 * (xlv_TEXCOORD0.x - sin((tmpvar_1 * 0.1)))) * sin((xlv_TEXCOORD0.y - sin((tmpvar_1 * 0.1))))) * 0.2)))) * 0.1));
  gl_FragData[0] = (tmpvar_7 + texture2D (_MainTex, xlv_TEXCOORD0));
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
; 339 ALU, 3 TEX
dcl_2d s0
def c1, 0.01750704, 0.50000000, 6.28318501, -3.14159298
def c2, 20.00000000, 1000.00000000, 0.00500000, 0.00100000
def c3, 0.15915491, 0.50000000, 0.00159155, 0.00318310
def c4, 5.00000000, 0.02387324, 0.50000000, 0.07957745
def c5, 22.00000000, 800.00000000, 0.01000000, 0.10000000
def c6, 0.00795775, 0.50000000, 0.00557042, 0.79577452
def c7, 0.01591549, 0.50000000, -0.50000000, 0.03183098
def c8, 3.00000000, 0.03978873, 0.50000000, 0.00636620
def c9, 0.09000000, 0.00000000, 1.00000000, 0
dcl_texcoord0 v0.xy
mov r0.x, c0
mad r0.y, r0.x, c1.x, c1
frc r0.y, r0
mov r0.x, c0
mad r0.x, r0, c4.y, c4.z
mad r1.x, r0.y, c1.z, c1.w
frc r1.y, r0.x
sincos r0.xy, r1.x
mad r0.x, r1.y, c1.z, c1.w
mad r5.y, r0, c2.x, c2
sincos r2.xy, r0.x
mad r0.x, r5.y, c2.z, v0
mad r0.y, r5, c3.z, c3
frc r0.y, r0
mad r0.x, r0, c3, c3.y
frc r0.x, r0
mad r1.x, r0.y, c1.z, c1.w
mad r2.x, r0, c1.z, c1.w
sincos r0.xy, r1.x
sincos r1.xy, r2.x
mul r0.z, r1.y, r0.x
mad r0.x, r5.y, c2.w, v0.y
mad r0.w, r5.y, c3, c3.y
mad r0.x, r0, c3, c3.y
frc r0.w, r0
mad r0.w, r0, c1.z, c1
sincos r1.xy, r0.w
frc r0.x, r0
mad r0.y, r2, c5.x, c5
mad r0.x, r0, c1.z, c1.w
sincos r2.xy, r0.x
mul r0.w, r2.x, r1.x
mul r1.xy, r0.zwzw, c4.x
mad r0.x, v0, c4, r0.y
mad r0.z, r0.x, c3.x, c3.y
frc r0.z, r0
mad r0.z, r0, c1, c1.w
sincos r2.xy, r0.z
mad r0.w, v0.y, c4, c4.z
frc r0.w, r0
texld r0.x, r1, s0
mad r0.z, r0.w, c1, c1.w
sincos r1.xy, r0.z
add r0.z, v0.y, c1.y
mad r0.w, r0.z, c3.x, c3.y
frc r0.w, r0
mad r0.z, r2.y, c5, r1.y
mul r0.z, r5.y, r0
mad r0.w, r0, c1.z, c1
sincos r1.xy, r0.w
mad r0.z, r0, c3.x, c3.y
add r0.w, v0.x, c7.z
frc r0.z, r0
mul r0.w, r5.y, r0
mul r0.w, r0, r1.y
mad r0.z, r0, c1, c1.w
sincos r1.xy, r0.z
mad r0.w, r0, c3.x, c3.y
frc r0.w, r0
mad r0.z, r0.w, c1, c1.w
sincos r3.xy, r0.z
mad r0.w, r5.y, c2.z, v0.y
mad r0.z, r5.y, c2.w, v0.x
mad r0.w, r0, c3.x, c3.y
mad r0.z, r0, c3.x, c3.y
frc r0.w, r0
frc r0.z, r0
mad r0.z, r0, c1, c1.w
sincos r2.xy, r0.z
mul r5.x, r0, r1.y
mad r0.w, r0, c1.z, c1
sincos r1.xy, r0.w
mov r1.y, r1.x
mov r1.x, r2.y
texld r1.x, r1, s0
mad r0.w, r5.y, c6.z, c6.y
frc r1.y, r0.w
abs r0.z, r3.y
mul r0.w, r5.y, r1.x
mul r0.z, r1.x, r0
mad r2.y, r1, c1.z, c1.w
sincos r1.xy, r2.y
mad r2.x, r0.y, c6, c6.y
frc r1.x, r2
mad r2.x, r1, c1.z, c1.w
add r2.y, v0, -r1
sincos r1.xy, r2.x
mad r1.x, r2.y, c6.w, c6.y
frc r1.z, r1.x
add r1.x, v0, -r1.y
mad r1.y, r1.z, c1.z, c1.w
sincos r4.xy, r1.y
mad r1.y, r5, c7.x, c7
frc r1.y, r1
mad r1.z, r1.y, c1, c1.w
sincos r2.xy, r1.z
mad r1.y, r0, c7.x, c7
frc r1.y, r1
mad r1.y, r1, c1.z, c1.w
sincos r3.xy, r1.y
add r1.z, v0.y, -r2.y
mad r1.y, r1.z, c3.x, c3
frc r1.y, r1
mad r2.z, r1.y, c1, c1.w
mul r1.x, r0.w, r1
mul r1.x, r1, r4.y
mad r1.x, r1, c5.w, r3.y
mad r2.x, r1, c3, c3.y
sincos r1.xy, r2.z
add r1.x, v0, -r2.y
mul r1.x, r5.y, r1
mul r1.y, r1.x, r1
frc r1.x, r2
mad r1.y, r1, c7.w, c7
mad r2.x, r1, c1.z, c1.w
frc r2.y, r1
sincos r1.xy, r2.x
mad r1.x, r2.y, c1.z, c1.w
sincos r2.xy, r1.x
mad r3.x, r5, r1.y, r0.z
mad r1.x, r0.y, c8.w, c8.z
frc r1.y, r1.x
mul r1.x, r0, r2.y
mul r2.x, r1, c5.w
mad r2.z, r1.y, c1, c1.w
sincos r1.xy, r2.z
add r1.x, v0, -r1.y
abs r1.z, r2.y
mul r1.y, r0.x, r1.z
mul r1.x, r0.w, r1
mad r5.y, r3.x, c1, r2.x
mul r0.w, r1.y, c5
mul r3.x, r4.y, r1
mad r1.x, v0, c8, r0.y
mad r1.y, v0, c8, c8.z
frc r1.y, r1
mad r1.x, r1, c3, c3.y
frc r1.x, r1
mad r2.x, r1.y, c1.z, c1.w
mad r3.z, r1.x, c1, c1.w
sincos r1.xy, r2.x
sincos r2.xy, r3.z
mad r1.x, r2.y, c5.z, r1.y
mul r0.y, r0, r1.x
mad r1.y, r3.x, c9.x, r3
mad r1.x, r1.y, c3, c3.y
frc r1.x, r1
mad r2.x, r1, c1.z, c1.w
sincos r1.xy, r2.x
mad r0.y, r0, c3.x, c3
frc r0.y, r0
mad r0.y, r0, c1.z, c1.w
sincos r2.xy, r0.y
abs r0.y, r1
mul r0.x, r0, r2.y
mad r0.x, r0, r0.y, r0.z
mad r5.z, r0.x, c1.y, r0.w
texld r0, v0, s0
mov r5.xw, c9.yyzz
add oC0, r5, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 16 [_TimeX]
BindCB  "$Globals" 0
"ps_4_0
eefiecedjehbalclaieegnmehegedfdpmknefkieabaaaaaaimaiaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaadadaaaafjaaaaaaaaaaaaaaabaaaaaa
adaaaaaaabaaaaaaapaaaaaagfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafeeffiedepepfceeaafdfgfpfaepfdejfeejepeoaaedepemepfcaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefclaahaaaaeaaaaaaa
omabaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaaaaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacagaaaaaadiaaaaakdcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaiadoaaaaaaaaaaaaaaaadiaaaaalpcaabaaa
abaaaaaaagiacaaaaaaaaaaaabaaaaaaaceaaaaakoehobdnjkjjbjdokoehobdn
jkjjbjdoenaaaaagpcaabaaaabaaaaaaaanaaaaaegaobaaaabaaaaaadcaaaaap
pcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaakaebaaaalaebaaaakaeb
aaaalaebaceaaaaaaaaahkeeaaaaeieeaaaahkeeaaaaeieedcaaaaammcaabaaa
aaaaaaaaagbabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaakaeaaaaaeaea
pgapbaaaabaaaaaaenaaaaagpcaabaaaaaaaaaaaaanaaaaaegaobaaaaaaaaaaa
dcaaaaamdcaabaaaaaaaaaaaogakbaaaaaaaaaaaaceaaaaaaknhcddmaknhcddm
aaaaaaaaaaaaaaaaegaabaaaaaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaogakbaaaabaaaaaaenaaaaagdcaabaaaaaaaaaaaaanaaaaaegaabaaa
aaaaaaaadiaaaaakmcaabaaaaaaaaaaakgakbaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaknhcddmaknhkddmenaaaaagaanaaaaamcaabaaaaaaaaaaakgaobaaa
aaaaaaaadcaaaaampcaabaaaacaaaaaakgakbaaaabaaaaaaaceaaaaaaknhkddl
gpbciddkgpbciddkaknhkddlegbebaaaaaaaaaaaenaaaaagdcaabaaaadaaaaaa
aanaaaaaigaabaaaacaaaaaaenaaaaagaanaaaaamcaabaaaadaaaaaafganbaaa
acaaaaaadiaaaaahmcaabaaaaaaaaaaakgaobaaaaaaaaaaaagaibaaaadaaaaaa
efaaaaajpcaabaaaacaaaaaangafbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaakmcaabaaaaaaaaaaakgaobaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaakaeaaaaakaeaefaaaaajpcaabaaaadaaaaaaogakbaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaagaabaaaadaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaabaaaaaa
akaabaaaacaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
omfblidndiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaknhcddn
enaaaaahicaabaaaaaaaaaaaaanaaaaadkaabaiaebaaaaaaaaaaaaaaaaaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakbabaaaaaaaaaaadiaaaaahecaabaaa
aaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaakpcaabaaaaeaaaaaa
egaobaaaabaaaaaaaceaaaaamnmmmmdnmnmmemdncjfmapdnmnmmmmdnenaaaaah
pcaabaaaafaaaaaaaanaaaaajgaabaiaebaaaaaaaeaaaaaaaaaaaaahpcaabaaa
afaaaaaaegaobaaaafaaaaaaegbebaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
bkaabaaaafaaaaaaabeaaaaaaaaakaeaenaaaaagicaabaaaaaaaaaaaaanaaaaa
dkaabaaaaaaaaaaaenaaaaagbcaabaaaabaaaaaaaanaaaaadkaabaaaaeaaaaaa
diaaaaahccaabaaaabaaaaaaakaabaaaacaaaaaaakaabaaaaeaaaaaadiaaaaah
ccaabaaaabaaaaaaakaabaaaafaaaaaabkaabaaaabaaaaaadcaaaaajccaabaaa
abaaaaaabkaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
enaaaaagecaabaaaaaaaaaaaaanaaaaackaabaaaaaaaaaaadiaaaaaiccaabaaa
aaaaaaaackaabaiaibaaaaaaaaaaaaaabkaabaaaaaaaaaaaenaaaaagecaabaaa
aaaaaaaaaanaaaaabkaabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaaaaaaaaaaaaaaaakmcaabaaaaaaaaaaaagbebaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaalpaaaaaadpdiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaackaabaaa
abaaaaaackaabaaaafaaaaaaenaaaaagccaabaaaabaaaaaaaanaaaaadkaabaaa
afaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaamnmmemdoenaaaaag
bcaabaaaabaaaaaaaanaaaaaakaabaaaabaaaaaaenaaaaagicaabaaaaaaaaaaa
aanaaaaadkaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaa
ckaabaaaaaaaaaaaenaaaaagecaabaaaaaaaaaaaaanaaaaackaabaaaaaaaaaaa
diaaaaaiecaabaaaaaaaaaaackaabaiaibaaaaaaaaaaaaaaakaabaaaacaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaaj
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaadpckaabaaaaaaaaaaa
dcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpckaabaaa
aaaaaaaadiaaaaaiecaabaaaaaaaaaaaakaabaiaibaaaaaaabaaaaaaakaabaaa
adaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaaadaaaaaa
dcaaaaajccaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaamnmmmmdnakaabaaa
aaaaaaaadcaaaaajecaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaamnmmmmdn
bkaabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadgaaaaaijcaabaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaiadpaaaaaaahpccabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaadoaaaaab"
}
}
 }
}
}