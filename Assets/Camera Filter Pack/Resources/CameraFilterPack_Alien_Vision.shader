Shader "CameraFilterPack/Alien_Vision" {
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
uniform float _Value2;
uniform float _Value;
uniform float _TimeX;
uniform sampler2D _MainTex;
void main ()
{
  vec4 thermal_1;
  vec3 col_2;
  float tmpvar_3;
  vec2 arg0_4;
  arg0_4 = (xlv_TEXCOORD0 - vec2(0.5, 0.5));
  tmpvar_3 = sqrt(dot (arg0_4, arg0_4));
  float tmpvar_5;
  tmpvar_5 = ((pow ((((1.0 + sin(((_TimeX * 6.0) * _Value2))) * 0.5) * (1.0 + (sin(((_TimeX * 16.0) * _Value2)) * 0.5))), 3.0) * 0.05) * tmpvar_3);
  vec2 tmpvar_6;
  tmpvar_6.x = (xlv_TEXCOORD0.x + tmpvar_5);
  tmpvar_6.y = xlv_TEXCOORD0.y;
  col_2.x = texture2D (_MainTex, tmpvar_6).x;
  col_2.y = texture2D (_MainTex, xlv_TEXCOORD0).y;
  vec2 tmpvar_7;
  tmpvar_7.x = (xlv_TEXCOORD0.x - tmpvar_5);
  tmpvar_7.y = xlv_TEXCOORD0.y;
  col_2.z = texture2D (_MainTex, tmpvar_7).z;
  vec3 tmpvar_8;
  tmpvar_8 = ((col_2 - (sin((xlv_TEXCOORD0.y * 800.0)) * 0.04)) * (1.0 - (tmpvar_3 * 0.5)));
  col_2 = tmpvar_8;
  vec4 tmpvar_9;
  tmpvar_9.xzw = vec3(0.0, 0.0, 1.0);
  tmpvar_9.y = (0.5 + (sin(_TimeX) / 4.14));
  vec4 tmpvar_10;
  tmpvar_10.xzw = vec3(0.1, 0.1, 1.0);
  tmpvar_10.y = (1.0 + (cos((_TimeX * 2.0)) / 4.14));
  vec4 tmpvar_11;
  tmpvar_11.xzw = vec3(0.1, 0.0, 1.0);
  tmpvar_11.y = (0.5 + (sin((_TimeX * 4.0)) / 4.14));
  float tmpvar_12;
  tmpvar_12 = (((tmpvar_8.x + tmpvar_8.y) + tmpvar_8.z) / 3.0);
  if ((tmpvar_12 < _Value)) {
    thermal_1 = mix (tmpvar_9, tmpvar_11, vec4((tmpvar_12 / _Value)));
  };
  if ((tmpvar_12 >= _Value)) {
    thermal_1 = mix (tmpvar_10, tmpvar_11, vec4(((tmpvar_12 - _Value) / _Value)));
  };
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = thermal_1.xyz;
  gl_FragData[0] = tmpvar_13;
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
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
; 110 ALU, 3 TEX
dcl_2d s0
def c3, 0.95492947, 0.50000000, 6.28318501, -3.14159298
def c4, 1.00000000, 2.54647851, 0.50000000, -0.50000000
def c5, 0.05000000, 127.32392883, 0.50000000, 0.04000000
def c6, 0.33333334, 0.31830981, 0.50000000, 0.63661963
def c7, 0.24154590, 1.00000000, 0.10000000, 0.00000000
def c8, 0.24154590, 0.50000000, 0.15915491, 0
dcl_texcoord0 v0.xy
mov r0.x, c0
mul r0.x, c2, r0
mad r0.y, r0.x, c3.x, c3
mad r0.z, r0.x, c4.y, c4
frc r0.y, r0
mad r0.x, r0.y, c3.z, c3.w
sincos r2.xy, r0.x
frc r0.y, r0.z
mad r1.w, r0.y, c3.z, c3
sincos r0.xy, r1.w
add r0.x, r2.y, c4
mad r0.y, r0, c4.z, c4.x
mul r0.x, r0, r0.y
add r0.zw, v0.xyxy, c4.w
mul r0.zw, r0, r0
add r0.y, r0.z, r0.w
rsq r0.z, r0.y
rcp r1.w, r0.z
mul r0.x, r0, c3.y
mul r0.y, r0.x, r0.x
mul r0.x, r0.y, r0
mul r0.w, r0.x, r1
mad r0.x, -r0.w, c5, v0
mov r0.y, v0
texld r2.z, r0, s0
mad r0.z, v0.y, c5.y, c5
frc r0.x, r0.z
mad r2.w, r0.x, c3.z, c3
mad r2.x, r0.w, c5, v0
sincos r0.xy, r2.w
mov r2.y, v0
texld r2.x, r2, s0
texld r2.y, v0, s0
mad r0.w, -r1, c4.z, c4.x
mad r0.xyz, -r0.y, c5.w, r2
mul r0.xyz, r0, r0.w
add r0.x, r0, r0.y
add r0.x, r0, r0.z
mul r0.x, r0, c6
rcp r3.w, c1.x
mov r0.y, c0.x
mad r0.y, r0, c8.z, c8
frc r0.y, r0
add r1.w, r0.x, -c1.x
mul r4.x, r0, r3.w
mov r0.x, c0
mad r0.x, r0, c6.w, c6.z
frc r0.x, r0
mad r0.x, r0, c3.z, c3.w
sincos r2.xy, r0.x
mad r3.x, r0.y, c3.z, c3.w
sincos r0.xy, r3.x
mov r0.x, c0
mad r0.w, r0.x, c6.y, c6.z
frc r0.w, r0
mad r0.y, r0, c8.x, c8
mov r0.xz, c7.w
mad r2.y, r2, c8.x, c8
mov r2.xz, c7.zyww
add r3.xyz, r2, -r0
mad r3.xyz, r4.x, r3, r0
cmp r1.xyz, r1.w, r1, r3
mad r2.w, r0, c3.z, c3
sincos r0.xy, r2.w
mad r3.y, r0.x, c7.x, c7
mov r3.xz, c7.z
add r0.xyz, r2, -r3
mul r0.w, r1, r3
mad r0.xyz, r0.w, r0, r3
cmp oC0.xyz, r1.w, r0, r1
mov oC0.w, c4.x
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 16 [_TimeX]
Float 20 [_Value]
Float 24 [_Value2]
BindCB  "$Globals" 0
"ps_4_0
eefiecedgbpmbiidkgopadejohgkcoobabdmfdgpabaaaaaacaahaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaadadaaaafjaaaaaaaaaaaaaaabaaaaaa
adaaaaaaabaaaaaaapaaaaaagfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafeeffiedepepfceeaafdfgfpfaepfdejfeejepeoaaedepemepfcaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefceeagaaaaeaaaaaaa
jbabaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaaaaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaadiaaaaajbcaabaaaaaaaaaaackiacaaa
aaaaaaaaabaaaaaaakiacaaaaaaaaaaaabaaaaaadiaaaaakdcaabaaaaaaaaaaa
agaabaaaaaaaaaaaaceaaaaaaaaamaeaaaaaiaebaaaaaaaaaaaaaaaaenaaaaag
dcaabaaaaaaaaaaaaanaaaaaegaabaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaajccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaadpdiaaaaahbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaaaaaaaaakgcaabaaaaaaaaaaaagbbbaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaalpaaaaaalpaaaaaaaaapaaaaahccaabaaaaaaaaaaajgafbaaaaaaaaaaa
jgafbaaaaaaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakccaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadp
dcaaaaajbcaabaaaabaaaaaaakaabaaaaaaaaaaaabeaaaaamnmmemdnakbabaaa
aaaaaaaadcaaaaakecaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaa
mnmmemdnakbabaaaaaaaaaaadgaaaaafkcaabaaaabaaaaaafgbfbaaaaaaaaaaa
efaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadgaaaaafecaabaaaacaaaaaackaabaaaabaaaaaadiaaaaah
bcaabaaaaaaaaaaabkbabaaaaaaaaaaaabeaaaaaaaaaeieeenaaaaagbcaabaaa
aaaaaaaaaanaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadgaaaaafccaabaaaacaaaaaa
bkaabaaaabaaaaaadcaaaaanncaabaaaaaaaaaaaagaabaiaebaaaaaaaaaaaaaa
aceaaaaaaknhcddnaaaaaaaaaknhcddnaknhcddnagajbaaaacaaaaaadiaaaaah
fcaabaaaaaaaaaaafgafbaaaaaaaaaaaagacbaaaaaaaaaaaaaaaaaahbcaabaaa
aaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
dkaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaklkkkkdodcaaaaalbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaklkkkkdobkiacaiaebaaaaaaaaaaaaaaabaaaaaa
bnaaaaaiecaabaaaaaaaaaaabkaabaaaaaaaaaaabkiacaaaaaaaaaaaabaaaaaa
aoaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaafgifcaaaaaaaaaaaabaaaaaa
aaaaaaajicaabaaaaaaaaaaaakiacaaaaaaaaaaaabaaaaaaakiacaaaaaaaaaaa
abaaaaaaenaaaaagaanaaaaaicaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaaj
icaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaampfhhhdoabeaaaaaaaaaiadp
diaaaaaiicaabaaaaaaaaaaaakiacaaaaaaaaaaaabaaaaaaabeaaaaaaaaaiaea
enaaaaagicaabaaaaaaaaaaaaanaaaaadkaabaaaaaaaaaaadcaaaaajccaabaaa
acaaaaaadkaabaaaaaaaaaaaabeaaaaampfhhhdoabeaaaaaaaaaaadpdgaaaaai
fcaabaaaacaaaaaaaceaaaaamnmmmmdnaaaaaaaaaaaaaaaaaaaaaaaadgaaaaai
fcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaamnmmmmdnaaaaaaaaaaaaaaai
hcaabaaaadaaaaaaogakbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaadcaaaaaj
hcaabaaaadaaaaaaagaabaaaaaaaaaaaegacbaaaadaaaaaaogakbaaaabaaaaaa
enaaaaahbcaabaaaaaaaaaaaaanaaaaaakiacaaaaaaaaaaaabaaaaaadcaaaaaj
ccaabaaaabaaaaaaakaabaaaaaaaaaaaabeaaaaampfhhhdoabeaaaaaaaaaaadp
aaaaaaaihcaabaaaacaaaaaaegaabaiaebaaaaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaajlcaabaaaaaaaaaaafgafbaaaaaaaaaaaegaibaaaacaaaaaaegaabaaa
abaaaaaadhaaaaajhccabaaaaaaaaaaakgakbaaaaaaaaaaaegacbaaaadaaaaaa
egadbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab
"
}
}
 }
}
}