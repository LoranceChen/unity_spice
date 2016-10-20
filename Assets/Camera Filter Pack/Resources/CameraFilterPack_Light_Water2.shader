Shader "CameraFilterPack/Light_Water2" {
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
  float alpha_1;
  vec2 c2_2;
  vec2 c1_3;
  c1_3 = xlv_TEXCOORD0;
  c2_2 = xlv_TEXCOORD0;
  vec2 coord_4;
  coord_4 = xlv_TEXCOORD0;
  int i_5;
  float col_6;
  float time_7;
  time_7 = (_TimeX * 1.3);
  col_6 = 0.0;
  i_5 = 0;
  for (int i_5 = 0; i_5 < 8; ) {
    vec2 adjc_8;
    float tmpvar_9;
    tmpvar_9 = (0.897598 * float(i_5));
    adjc_8.x = (coord_4.x + (((cos(tmpvar_9) * time_7) * _Value) + (time_7 * _Value2)));
    adjc_8.y = (coord_4.y - (((sin(tmpvar_9) * time_7) * _Value) - (time_7 * _Value3)));
    col_6 = (col_6 + (cos((((adjc_8.x * cos(tmpvar_9)) - (adjc_8.y * sin(tmpvar_9))) * 6.0)) * _Value4));
    i_5 = (i_5 + 1);
  };
  float tmpvar_10;
  tmpvar_10 = cos(col_6);
  c2_2.x = (xlv_TEXCOORD0.x + 8.53);
  vec2 coord_11;
  coord_11 = c2_2;
  int i_12;
  float col_13;
  float time_14;
  time_14 = (_TimeX * 1.3);
  col_13 = 0.0;
  i_12 = 0;
  for (int i_12 = 0; i_12 < 8; ) {
    vec2 adjc_15;
    float tmpvar_16;
    tmpvar_16 = (0.897598 * float(i_12));
    adjc_15.x = (coord_11.x + (((cos(tmpvar_16) * time_14) * _Value) + (time_14 * _Value2)));
    adjc_15.y = (coord_11.y - (((sin(tmpvar_16) * time_14) * _Value) - (time_14 * _Value3)));
    col_13 = (col_13 + (cos((((adjc_15.x * cos(tmpvar_16)) - (adjc_15.y * sin(tmpvar_16))) * 6.0)) * _Value4));
    i_12 = (i_12 + 1);
  };
  float tmpvar_17;
  tmpvar_17 = ((0.5 * (tmpvar_10 - cos(col_13))) / 60.0);
  c2_2.x = xlv_TEXCOORD0.x;
  c2_2.y = (xlv_TEXCOORD0.y + 8.53);
  vec2 coord_18;
  coord_18 = c2_2;
  int i_19;
  float col_20;
  float time_21;
  time_21 = (_TimeX * 1.3);
  col_20 = 0.0;
  i_19 = 0;
  for (int i_19 = 0; i_19 < 8; ) {
    vec2 adjc_22;
    float tmpvar_23;
    tmpvar_23 = (0.897598 * float(i_19));
    adjc_22.x = (coord_18.x + (((cos(tmpvar_23) * time_21) * _Value) + (time_21 * _Value2)));
    adjc_22.y = (coord_18.y - (((sin(tmpvar_23) * time_21) * _Value) - (time_21 * _Value3)));
    col_20 = (col_20 + (cos((((adjc_22.x * cos(tmpvar_23)) - (adjc_22.y * sin(tmpvar_23))) * 6.0)) * _Value4));
    i_19 = (i_19 + 1);
  };
  float tmpvar_24;
  tmpvar_24 = ((0.5 * (tmpvar_10 - cos(col_20))) / 60.0);
  c1_3.x = (xlv_TEXCOORD0.x + (tmpvar_17 * 2.0));
  c1_3.y = (xlv_TEXCOORD0.y + (tmpvar_24 * 2.0));
  float tmpvar_25;
  tmpvar_25 = (1.0 + ((tmpvar_17 * tmpvar_24) * 700.0));
  alpha_1 = tmpvar_25;
  float tmpvar_26;
  tmpvar_26 = (tmpvar_17 - 0.012);
  float tmpvar_27;
  tmpvar_27 = (tmpvar_24 - 0.012);
  if (((tmpvar_26 > 0.0) && (tmpvar_27 > 0.0))) {
    alpha_1 = pow (tmpvar_25, ((tmpvar_26 * tmpvar_27) * 200000.0));
  };
  gl_FragData[0] = (texture2D (_MainTex, c1_3) * alpha_1);
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
; 173 ALU, 1 TEX, 15 FLOW
dcl_2d s0
def c5, 1.29999995, 0.00000000, 0.89759791, 1.00000000
defi i0, 8, 0, 1, 0
def c6, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c7, 0.95492947, 0.50000000, 8.52999973, 0.00833333
def c8, 2.00000000, -0.01200000, 700.00000000, 1.00000000
def c9, 200000.00000000, 0, 0, 0
dcl_texcoord0 v0.xy
mov r0.x, c0
mul r1.x, c5, r0
mov r1.z, c5.y
mov r1.y, c5
loop aL, i0
mul r0.x, r1.y, c5.z
mad r0.x, r0, c6, c6.y
frc r0.x, r0
mad r1.w, r0.x, c6.z, c6
sincos r0.xy, r1.w
mul r0.w, r1.x, c3.x
mul r0.z, r1.x, r0.y
mad r0.z, r0, c1.x, -r0.w
add r1.w, v0.y, -r0.z
mul r0.w, r1.x, c2.x
mul r0.z, r1.x, r0.x
mad r0.z, r0, c1.x, r0.w
mul r0.w, r1, r0.y
add r0.y, v0.x, r0.z
mad r0.x, r0.y, r0, -r0.w
mad r0.x, r0, c7, c7.y
frc r0.x, r0
mad r1.w, r0.x, c6.z, c6
sincos r0.xy, r1.w
mad r1.z, r0.x, c4.x, r1
add r1.y, r1, c5.w
endloop
mad r0.x, r1.z, c6, c6.y
frc r0.x, r0
mad r1.x, r0, c6.z, c6.w
sincos r0.xy, r1.x
mov r0.y, c0.x
add r0.z, v0.x, c7
mul r0.y, c5.x, r0
mov r0.w, c5.y
mov r2.x, c5.y
loop aL, i0
mul r1.x, r2, c5.z
mad r1.x, r1, c6, c6.y
frc r1.x, r1
mad r2.y, r1.x, c6.z, c6.w
sincos r1.xy, r2.y
mul r1.w, r0.y, c3.x
mul r1.z, r0.y, r1.y
mad r1.z, r1, c1.x, -r1.w
add r2.y, v0, -r1.z
mul r1.w, r0.y, c2.x
mul r1.z, r0.y, r1.x
mad r1.z, r1, c1.x, r1.w
mul r1.w, r2.y, r1.y
add r1.y, r0.z, r1.z
mad r1.x, r1.y, r1, -r1.w
mad r1.x, r1, c7, c7.y
frc r1.x, r1
mad r2.y, r1.x, c6.z, c6.w
sincos r1.xy, r2.y
mad r0.w, r1.x, c4.x, r0
add r2.x, r2, c5.w
endloop
mad r0.y, r0.w, c6.x, c6
frc r0.y, r0
mad r0.y, r0, c6.z, c6.w
sincos r1.xy, r0.y
add r0.y, r0.x, -r1.x
mov r0.z, c0.x
mul r0.y, r0, c7.w
add r0.w, v0.y, c7.z
mul r0.z, c5.x, r0
mov r2.x, c5.y
mov r2.y, c5
loop aL, i0
mul r1.x, r2.y, c5.z
mad r1.x, r1, c6, c6.y
frc r1.x, r1
mad r2.z, r1.x, c6, c6.w
sincos r1.xy, r2.z
mul r1.w, r0.z, c3.x
mul r1.z, r0, r1.y
mad r1.z, r1, c1.x, -r1.w
add r2.z, r0.w, -r1
mul r1.w, r0.z, c2.x
mul r1.z, r0, r1.x
mad r1.z, r1, c1.x, r1.w
mul r1.w, r2.z, r1.y
add r1.y, v0.x, r1.z
mad r1.x, r1.y, r1, -r1.w
mad r1.x, r1, c7, c7.y
frc r1.x, r1
mad r2.z, r1.x, c6, c6.w
sincos r1.xy, r2.z
mad r2.x, r1, c4, r2
add r2.y, r2, c5.w
endloop
mad r0.z, r2.x, c6.x, c6.y
frc r0.z, r0
mad r0.z, r0, c6, c6.w
sincos r1.xy, r0.z
add r0.x, r0, -r1
mul r0.z, r0.x, c7.w
mul r0.x, r0.z, r0.y
add r2.x, r0.z, c8.y
add r0.w, r0.y, c8.y
mul r1.x, r0.w, r2
mad r0.x, r0, c8.z, c8.w
mul r2.y, r1.x, c9.x
pow r1, r0.x, r2.y
mov r1.y, r1.x
cmp r1.x, -r2, c5.y, c5.w
cmp r0.w, -r0, c5.y, c5
mul_pp r0.w, r0, r1.x
cmp r1.x, -r0.w, r0, r1.y
mad r0.x, r0.y, c8, v0
mad r0.y, r0.z, c8.x, v0
texld r0, r0, s0
mul oC0, r0, r1.x
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
eefiecedfmedbabfkpnhjokljinidegbhmmkadlbabaaaaaamiakaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaadadaaaafjaaaaaaaaaaaaaaabaaaaaa
adaaaaaaabaaaaaaapaaaaaagfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafeeffiedepepfceeaafdfgfpfaepfdejfeejepeoaaedepemepfcaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcomajaaaaeaaaaaaa
hlacaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaaaaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaadiaaaaaibcaabaaaaaaaaaaaakiacaaa
aaaaaaaaabaaaaaaabeaaaaaggggkgdpdiaaaaaigcaabaaaaaaaaaaaagaabaaa
aaaaaaaakgilcaaaaaaaaaaaabaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaa
aaaaaaaadgaaaaafbcaabaaaabaaaaaaabeaaaaaaaaaaaaadaaaaaabcbaaaaah
ccaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaiaaaaaaadaaaeadbkaabaaa
abaaaaaaclaaaaafccaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaapkmigfdpenaaaaahbcaabaaaacaaaaaa
bcaabaaaadaaaaaabkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaaakaabaaa
aaaaaaaaakaabaaaadaaaaaadcaaaaakccaabaaaabaaaaaabkaabaaaabaaaaaa
bkiacaaaaaaaaaaaabaaaaaabkaabaaaaaaaaaaaaaaaaaahccaabaaaabaaaaaa
bkaabaaaabaaaaaaakbabaaaaaaaaaaadiaaaaahecaabaaaabaaaaaaakaabaaa
aaaaaaaaakaabaaaacaaaaaadcaaaaalecaabaaaabaaaaaackaabaaaabaaaaaa
bkiacaaaaaaaaaaaabaaaaaackaabaiaebaaaaaaaaaaaaaaaaaaaaaiecaabaaa
abaaaaaackaabaiaebaaaaaaabaaaaaabkbabaaaaaaaaaaadiaaaaahecaabaaa
abaaaaaaakaabaaaacaaaaaackaabaaaabaaaaaadcaaaaakccaabaaaabaaaaaa
bkaabaaaabaaaaaaakaabaaaadaaaaaackaabaiaebaaaaaaabaaaaaadiaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaamaeaenaaaaagaanaaaaa
ccaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaabkaabaaa
abaaaaaaakiacaaaaaaaaaaaacaaaaaadkaabaaaaaaaaaaaboaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaabaaaaaabgaaaaabenaaaaagaanaaaaa
icaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaakdcaabaaaabaaaaaaegbabaaa
aaaaaaaaaceaaaaaobhkaiebobhkaiebaaaaaaaaaaaaaaaadgaaaaaimcaabaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadaaaaaabcbaaaaah
bcaabaaaacaaaaaadkaabaaaabaaaaaaabeaaaaaaiaaaaaaadaaaeadakaabaaa
acaaaaaaclaaaaafbcaabaaaacaaaaaadkaabaaaabaaaaaadiaaaaahbcaabaaa
acaaaaaaakaabaaaacaaaaaaabeaaaaapkmigfdpenaaaaahbcaabaaaacaaaaaa
bcaabaaaadaaaaaaakaabaaaacaaaaaadiaaaaahccaabaaaacaaaaaaakaabaaa
aaaaaaaaakaabaaaadaaaaaadcaaaaakccaabaaaacaaaaaabkaabaaaacaaaaaa
bkiacaaaaaaaaaaaabaaaaaabkaabaaaaaaaaaaaaaaaaaahccaabaaaacaaaaaa
akaabaaaabaaaaaabkaabaaaacaaaaaadiaaaaahecaabaaaacaaaaaaakaabaaa
aaaaaaaaakaabaaaacaaaaaadcaaaaalecaabaaaacaaaaaackaabaaaacaaaaaa
bkiacaaaaaaaaaaaabaaaaaackaabaiaebaaaaaaaaaaaaaaaaaaaaaiecaabaaa
acaaaaaackaabaiaebaaaaaaacaaaaaabkbabaaaaaaaaaaadiaaaaahbcaabaaa
acaaaaaaakaabaaaacaaaaaackaabaaaacaaaaaadcaaaaakbcaabaaaacaaaaaa
bkaabaaaacaaaaaaakaabaaaadaaaaaaakaabaiaebaaaaaaacaaaaaadiaaaaah
bcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaamaeaenaaaaagaanaaaaa
bcaabaaaacaaaaaaakaabaaaacaaaaaadcaaaaakecaabaaaabaaaaaaakaabaaa
acaaaaaaakiacaaaaaaaaaaaacaaaaaackaabaaaabaaaaaaboaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaaabaaaaaabgaaaaabenaaaaagaanaaaaa
bcaabaaaabaaaaaackaabaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaadkaabaaa
aaaaaaaaakaabaiaebaaaaaaabaaaaaadgaaaaaimcaabaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadaaaaaabcbaaaaahbcaabaaaacaaaaaa
dkaabaaaabaaaaaaabeaaaaaaiaaaaaaadaaaeadakaabaaaacaaaaaaclaaaaaf
bcaabaaaacaaaaaadkaabaaaabaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaaabeaaaaapkmigfdpenaaaaahbcaabaaaacaaaaaabcaabaaaadaaaaaa
akaabaaaacaaaaaadiaaaaahccaabaaaacaaaaaaakaabaaaaaaaaaaaakaabaaa
adaaaaaadcaaaaakccaabaaaacaaaaaabkaabaaaacaaaaaabkiacaaaaaaaaaaa
abaaaaaabkaabaaaaaaaaaaaaaaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaa
akbabaaaaaaaaaaadiaaaaahecaabaaaacaaaaaaakaabaaaaaaaaaaaakaabaaa
acaaaaaadcaaaaalecaabaaaacaaaaaackaabaaaacaaaaaabkiacaaaaaaaaaaa
abaaaaaackaabaiaebaaaaaaaaaaaaaaaaaaaaaiecaabaaaacaaaaaabkaabaaa
abaaaaaackaabaiaebaaaaaaacaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaackaabaaaacaaaaaadcaaaaakbcaabaaaacaaaaaabkaabaaaacaaaaaa
akaabaaaadaaaaaaakaabaiaebaaaaaaacaaaaaadiaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaaabeaaaaaaaaamaeaenaaaaagaanaaaaabcaabaaaacaaaaaa
akaabaaaacaaaaaadcaaaaakecaabaaaabaaaaaaakaabaaaacaaaaaaakiacaaa
aaaaaaaaacaaaaaackaabaaaabaaaaaaboaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaabaaaaaabgaaaaabenaaaaagaanaaaaabcaabaaaaaaaaaaa
ckaabaaaabaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaa
ijiiaidmdcaaaaajbcaabaaaacaaaaaaakaabaaaabaaaaaaabeaaaaaijiiiidm
akbabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
ijiiaidmdcaaaaajccaabaaaacaaaaaaakaabaaaaaaaaaaaabeaaaaaijiiiidm
bkbabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaa
aaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaacpee
abeaaaaaaaaaiadpdcaaaaajecaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaa
ijiiaidmabeaaaaakgjleelmdcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaijiiaidmabeaaaaakgjleelmdbaaaaahicaabaaaaaaaaaaaabeaaaaa
aaaaaaaackaabaaaaaaaaaaadbaaaaahbcaabaaaabaaaaaaabeaaaaaaaaaaaaa
akaabaaaaaaaaaaaabaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaafaedeicpaaaaaf
ecaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaaaaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dhaaaaajbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahpccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadoaaaaab"
}
}
 }
}
}