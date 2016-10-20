Shader "ClayShader/Clay" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _MainTex2 ("Base (RGB)", 2D) = "white" {}
 _TimeX ("Time", Range(0,1)) = 1
 _Distortion ("_Distortion", Range(0,1)) = 0.3
 _DotSize ("_DotSize", Range(0,1)) = 0
 _ColorLevel ("_ColorLevel", Range(0,10)) = 7
 _Inverse ("_Inverse", Range(0,1)) = 0
 _BackGroundX ("_BackGroundX", Range(0,1)) = 0
 _BackGroundY ("_BackGroundY", Range(0,1)) = 0
}
SubShader { 
 Pass {
  ZTest Always
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
"3.0-!!ARBvp1.0
# 6 ALU
PARAM c[5] = { program.local[0],
		state.matrix.mvp };
MOV result.color, vertex.color;
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
Vector 0 [_Time]
Float 1 [_Distortion]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MainTex2] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 62 ALU, 2 TEX
PARAM c[6] = { program.local[0..1],
		{ 2.6666667, 0, 0.125, 0.875 },
		{ 0.75, 0.625, 0.5, 0.375 },
		{ 0.25, 0.22727272, 0.0125, 200 },
		{ 0.00390625, 180, 150, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
ADD R1.xyz, R1, c[1].x;
ADD R0.x, R1, R1.y;
ADD R0.x, R0, R1.z;
MOV R1.zw, c[5].xyyz;
MUL R0.x, R0, c[2];
FLR R2.z, R0.x;
MOV R0.y, c[4].w;
MUL R0.y, R0, c[0].x;
SIN R0.x, R0.y;
FLR R1.x, R0;
MUL R2.x, R1, c[5];
MAD R0.xy, fragment.texcoord[0], c[4].y, c[4].z;
MAD R2.y, R2.z, c[2].z, -c[2].z;
MUL R1.w, R1, c[0].x;
MOV R1.y, c[3].z;
ADD R1.x, R2, c[3].z;
ADD R1.xy, R0, R1;
CMP R0.zw, -R2.y, R0, R1.xyxy;
MUL R1.x, R1.z, c[0];
SIN R1.y, R1.x;
MUL R1.z, R2, c[2];
ADD R1.x, R1.z, -c[4];
FLR R1.y, R1;
MUL R2.y, R1, c[5].x;
ABS R2.w, R1.x;
ADD R1.x, R2.y, c[4];
MOV R1.y, c[3].z;
ADD R1.xy, R0, R1;
CMP R1.xy, -R2.w, R0.zwzw, R1;
SIN R0.z, R1.w;
FLR R0.z, R0;
ADD R1.w, R1.z, -c[3];
MOV R0.w, c[3].z;
MUL R0.z, R0, c[5].x;
ADD R3.xy, R0, R0.zwzw;
ABS R0.w, R1;
CMP R3.xy, -R0.w, R1, R3;
ADD R0.w, R1.z, -c[3].z;
ABS R0.w, R0;
ADD R2.w, R1.z, -c[3].y;
MOV R1.y, c[3].x;
ADD R1.x, R2, c[3];
ADD R1.xy, R0, R1;
CMP R1.xy, -R0.w, R3, R1;
ADD R0.w, R1.z, -c[3].x;
ADD R1.z, R2.y, c[3];
MOV R1.w, c[3].x;
ADD R1.zw, R0.xyxy, R1;
ABS R2.y, R2.w;
CMP R1.xy, -R2.y, R1, R1.zwzw;
ABS R1.z, R0.w;
MOV R0.w, c[3].x;
ADD R0.z, R0, c[4].x;
ADD R0.zw, R0.xyxy, R0;
CMP R0.zw, -R1.z, R1.xyxy, R0;
MOV R2.y, c[3].x;
ADD R1.xy, R0, R2;
MAD R0.x, R2.z, c[2].z, -c[2].w;
CMP R0.xy, R0.x, R0.zwzw, R1;
TEX result.color.xyz, R0, texture[1], 2D;
MOV result.color.w, c[5];
END
# 62 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_Time]
Float 1 [_Distortion]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MainTex2] 2D 1
"ps_3_0
; 90 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c2, 2.66666675, 0.12500000, -0.87500000, 0.00390625
def c3, 0.22727272, 0.01250000, 31.83098221, 0.50000000
def c4, 6.28318501, -3.14159298, 0.75000000, 0.25000000
def c5, 0.12500000, -0.75000000, 23.87323570, 0.50000000
def c6, 0.12500000, -0.62500000, 28.64788246, 0.50000000
def c7, 0.00390625, 0.50000000, 0.12500000, -0.50000000
def c8, 0.12500000, -0.37500000, -0.25000000, 1.00000000
def c9, 0.00390625, 0.25000000, 0, 0
dcl_texcoord0 v0.xy
mov r0.w, c0.x
texld r0.xyz, v0, s0
add r0.xyz, r0, c1.x
add r0.x, r0, r0.y
mad r0.w, r0, c3.z, c3
frc r0.w, r0
mad r1.y, r0.w, c4.x, c4
add r1.x, r0, r0.z
sincos r0.xy, r1.y
mul r0.x, r1, c2
frc r0.z, r0.x
add r3.x, r0, -r0.z
frc r0.w, r0.y
add r0.x, r0.y, -r0.w
mul r2.z, r0.x, c2.w
mov r0.y, c0.x
mad r0.y, r0, c6.z, c6.w
frc r0.z, r0.y
mad r1.xy, v0, c3.x, c3.y
mad r2.w, r3.x, c2.y, -c2.y
add r0.x, r2.z, c3.w
mov r0.y, c3.w
add r2.xy, r1, r0
mad r3.y, r0.z, c4.x, c4
sincos r0.xy, r3.y
cmp r0.zw, -r2.w, r2.xyxy, r1
frc r0.x, r0.y
add r2.x, r0.y, -r0
mov r0.y, c0.x
mad r1.w, r0.y, c5.z, c5
frc r1.w, r1
mad r1.z, r3.x, c8.x, c8
mad r2.y, r1.w, c4.x, c4
abs r1.z, r1
mad r0.x, r2, c9, c9.y
mov r0.y, c3.w
add r0.xy, r1, r0
cmp r1.zw, -r1.z, r0.xyxy, r0
sincos r0.xy, r2.y
mad r0.z, r3.x, c8.x, c8.y
frc r0.x, r0.y
add r0.x, r0.y, -r0
abs r2.w, r0.z
mad r2.y, r3.x, c7.z, c7.w
mov r0.y, c3.w
mul r0.x, r0, c2.w
add r0.zw, r1.xyxy, r0.xyxy
cmp r1.zw, -r2.w, r0, r1
abs r0.y, r2
mov r0.w, c4.z
add r0.z, r2, c4
add r0.zw, r1.xyxy, r0
cmp r0.zw, -r0.y, r0, r1
mad r1.z, r3.x, c6.x, c6.y
abs r2.y, r1.z
mad r0.y, r3.x, c5.x, c5
mov r1.w, c4.z
mad r1.z, r2.x, c7.x, c7.y
add r1.zw, r1.xyxy, r1
cmp r0.zw, -r2.y, r1, r0
abs r1.z, r0.y
mov r0.y, c4.z
add r0.x, r0, c4.w
add r0.xy, r1, r0
cmp r0.xy, -r1.z, r0, r0.zwzw
mov r2.w, c4.z
mad r0.z, r3.x, c2.y, c2
add r1.xy, r1, r2.zwzw
cmp r0.xy, r0.z, r1, r0
texld oC0.xyz, r0, s1
mov oC0.w, c8
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MainTex2] 2D 1
ConstBuffer "$Globals" 48
Float 20 [_Distortion]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedapejamlcccheoigjdppalicemjenkbakabaaaaaakiafaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaadadaaaafjaaaaaaaaaaaaaaabaaaaaa
adaaaaaaabaaaaaaapaaaaaagfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafeeffiedepepfceeaafdfgfpfaepfdejfeejepeoaaedepemepfcaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmmaeaaaaeaaaaaaa
ddabaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
dcbabaaaaaaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakbabaaaaaaaaaaaabeaaaaacolkgidoabeaaaaamnmmemdm
diaaaaalocaabaaaaaaaaaaaagiacaaaabaaaaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaeiedaaaadeedaaaabgedenaaaaagocaabaaaaaaaaaaaaanaaaaafgaobaaa
aaaaaaaaebaaaaafocaabaaaaaaaaaaafgaobaaaaaaaaaaadcaaaaamgcaabaaa
abaaaaaafgagbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaiadlaaaaiadlaaaaaaaa
agaabaaaaaaaaaaadiaaaaakfcaabaaaaaaaaaaafgahbaaaaaaaaaaaaceaaaaa
aaaaiadlaaaaaaaaaaaaiadlaaaaaaaadiaaaaahicaabaaaabaaaaaabkbabaaa
aaaaaaaaabeaaaaacolkgidoaaaaaaakpcaabaaaacaaaaaangaobaaaabaaaaaa
aceaaaaaaaaaaadpddddaddpaaaaiadoddddaddpaaaaaaakpcaabaaaabaaaaaa
ngaobaaaabaaaaaaaceaaaaaaaaaeadpddddeddpaaaaaadpddddeddpefaaaaaj
pcaabaaaadaaaaaaegbabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaaihcaabaaaadaaaaaaegacbaaaadaaaaaafgifcaaaaaaaaaaaabaaaaaa
aaaaaaahbcaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaaaaaaaaah
bcaabaaaadaaaaaackaabaaaadaaaaaaakaabaaaadaaaaaadiaaaaahbcaabaaa
adaaaaaaakaabaaaadaaaaaaabeaaaaaklkkckeaebaaaaafbcaabaaaadaaaaaa
akaabaaaadaaaaaabiaaaaakpcaabaaaaeaaaaaaagaabaaaadaaaaaaaceaaaaa
aaaaaaeaaaaaeaeaaaaaiaeaaaaakaeadhaaaaajdcaabaaaacaaaaaaagaabaaa
aeaaaaaaogakbaaaacaaaaaaegaabaaaacaaaaaadgaaaaaikcaabaaaaaaaaaaa
aceaaaaaaaaaaaaaddddeddpaaaaaaaaddddaddpdcaaaaapmcaabaaaacaaaaaa
agbebaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaacolkgidocolkgidoaceaaaaa
aaaaaaaaaaaaaaaamnmmemdmaaaaaaaaaaaaaaahdcaabaaaafaaaaaaogakbaaa
aaaaaaaaogakbaaaacaaaaaadhaaaaajmcaabaaaaaaaaaaafgafbaaaaeaaaaaa
agaebaaaafaaaaaaagaebaaaacaaaaaadhaaaaajmcaabaaaaaaaaaaakgakbaaa
aeaaaaaaagaebaaaabaaaaaakgaobaaaaaaaaaaadhaaaaajmcaabaaaaaaaaaaa
pgapbaaaaeaaaaaakgaobaaaabaaaaaakgaobaaaaaaaaaaabiaaaaahbcaabaaa
abaaaaaaakaabaaaadaaaaaaabeaaaaaaaaamaeabnaaaaahccaabaaaabaaaaaa
akaabaaaadaaaaaaabeaaaaaaaaaoaeadiaaaaahecaabaaaafaaaaaabkbabaaa
aaaaaaaaabeaaaaacolkgidoaaaaaaakmcaabaaaabaaaaaaagaibaaaafaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaiadoddddeddpdhaaaaajmcaabaaaaaaaaaaa
agaabaaaabaaaaaakgaobaaaabaaaaaakgaobaaaaaaaaaaaaaaaaaahdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaogakbaaaacaaaaaadhaaaaajdcaabaaaaaaaaaaa
fgafbaaaabaaaaaaegaabaaaaaaaaaaaogakbaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadgaaaaaf
hccabaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaiadpdoaaaaab"
}
}
 }
}
}