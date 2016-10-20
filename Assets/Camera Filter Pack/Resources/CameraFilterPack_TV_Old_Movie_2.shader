Shader "CameraFilterPack/TV_Old_Movie_2" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _TimeX ("Time", Range(0,1)) = 1
 _Distortion ("_Distortion", Range(1,10)) = 1
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
Float 0 [_TimeX]
Float 1 [_Value]
Float 2 [_Value2]
Float 3 [_Value3]
Float 4 [_Value4]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 265 ALU, 1 TEX
PARAM c[15] = { program.local[0..4],
		{ 0, 1, 12.9898, 78.233002 },
		{ 43758.547, 23, 0.0020000001, 0.69999999 },
		{ 0.21259999, 0.71520001, 0.0722, 0.5 },
		{ 0.125, 18, 8, 2 },
		{ 0.40000001, 0.30000001, 16, 0.2 },
		{ 7, 0, 0.0099999998, 24 },
		{ 6, 50, -0.01348047, 0.05747731 },
		{ 0.1212391, 0.1956359, 0.33299461, 0.99999559 },
		{ 1.570796, 6.2831001, 0.1, 0.0625 },
		{ 25, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.x, c[1];
MUL R0.x, R0, c[0];
ABS R0.y, R0.x;
FLR R0.y, R0;
SLT R0.x, R0, c[5];
CMP R2.x, -R0, -R0.y, R0.y;
ADD R0.z, R2.x, c[11].x;
ADD R0.x, R0.z, c[5].y;
MOV R0.y, c[5];
MUL R1.xy, R0, c[5].zwzw;
MOV R0.w, c[5].y;
MUL R0.xy, R0.zwzw, c[5].zwzw;
ADD R0.x, R0, R0.y;
ADD R0.w, R1.x, R1.y;
SIN R0.y, R0.w;
MUL R0.y, R0, c[6].x;
SIN R0.x, R0.x;
MUL R0.x, R0, c[6];
FRC R1.x, R0;
FRC R1.y, R0;
ADD R0.xy, -fragment.texcoord[0], R1;
RCP R0.w, R0.x;
MUL R0.w, R0.y, R0;
ABS R1.y, R0.w;
MAX R1.z, R1.y, c[5].y;
RCP R1.w, R1.z;
MIN R1.z, R1.y, c[5].y;
MUL R1.z, R1, R1.w;
MUL R1.w, R1.z, R1.z;
MAD R2.y, R1.w, c[11].z, c[11].w;
MAD R2.y, R2, R1.w, -c[12].x;
MAD R2.y, R2, R1.w, c[12];
MAD R2.y, R2, R1.w, -c[12].z;
MAD R1.w, R2.y, R1, c[12];
MUL R1.z, R1.w, R1;
ADD R1.w, -R1.z, c[13].x;
ADD R1.y, R1, -c[5];
CMP R1.y, -R1, R1.w, R1.z;
CMP R0.w, R0, -R1.y, R1.y;
MUL R0.w, R1.x, R0;
MUL R1.xy, R0, R0;
MUL R0.w, R0, c[13].y;
SIN R0.w, R0.w;
MUL R0.w, R0, c[13].z;
ADD R2.w, R1.x, R1.y;
ADD R1.z, R0, c[8].w;
MOV R1.w, c[5].y;
MUL R1.zw, R1, c[5];
ADD R0.z, R1, R1.w;
SIN R0.z, R0.z;
MUL R0.z, R0, c[6].x;
FRC R0.z, R0;
MUL R2.z, R0, c[10];
MUL R0.z, R2, R2;
ADD R0.w, R0, c[5].y;
MUL R1.w, R0.z, R0;
SLT R0.y, R2.w, R1.w;
ABS R0.y, R0;
MUL R2.z, -R2, c[11].y;
ADD R2.z, R2, c[5].y;
MUL R2.z, R2, c[9].w;
ADD R2.z, R2, -c[4].x;
CMP R2.y, -R0, c[5].x, c[5];
ADD R2.z, R2, c[9].y;
ADD R0.z, R2.x, c[8].y;
MOV R0.w, c[5].y;
MUL R0.zw, R0, c[5];
ADD R0.x, R0.z, R0.w;
SIN R0.x, R0.x;
MUL R0.x, R0, c[6];
FRC R0.x, R0;
MAD R0.y, R0.x, c[8].z, -c[8].w;
ADD R0.x, R2, c[14];
MAX R1.z, R0.y, c[5].x;
MOV R0.y, c[5];
MUL R1.xy, R0, c[5].zwzw;
ADD R0.y, R1.x, R1;
SIN R0.y, R0.y;
ADD R0.z, R0.x, c[5].y;
MOV R0.w, c[5].y;
MUL R0.zw, R0, c[5];
ADD R0.z, R0, R0.w;
SIN R0.z, R0.z;
MUL R0.z, R0, c[6].x;
FRC R0.w, R0.z;
MUL R0.y, R0, c[6].x;
FRC R0.z, R0.y;
ADD R1.xy, -fragment.texcoord[0], R0.zwzw;
ABS R0.y, R1.z;
FLR R0.w, R0.y;
SLT R0.y, R1.z, c[5].x;
CMP R0.w, -R0.y, -R0, R0;
RCP R3.x, R1.x;
MUL R1.z, R1.y, R3.x;
SLT R0.y, c[5].x, R0.w;
MUL R3.x, R0.y, R2.y;
ADD R0.y, R2.w, -R1.w;
ABS R2.y, R1.z;
POW R1.w, R0.y, c[13].w;
MAX R2.w, R2.y, c[5].y;
CMP R1.w, -R3.x, R1, c[9];
RCP R2.w, R2.w;
MIN R0.y, R2, c[5];
MUL R0.y, R0, R2.w;
MUL R2.w, R0.y, R0.y;
MAD R3.x, R2.w, c[11].z, c[11].w;
MAD R3.x, R3, R2.w, -c[12];
MAD R3.x, R3, R2.w, c[12].y;
MAD R3.x, R3, R2.w, -c[12].z;
MAD R3.x, R3, R2.w, c[12].w;
MUL R3.x, R3, R0.y;
ADD R2.w, -R2.z, c[5].y;
MAD R0.y, R1.w, R2.w, R2.z;
ADD R2.z, -R3.x, c[13].x;
ADD R1.w, R2.y, -c[5].y;
CMP R1.w, -R1, R2.z, R3.x;
CMP R1.z, R1, -R1.w, R1.w;
MUL R0.z, R0, R1;
MUL R0.z, R0, c[13].y;
SIN R0.z, R0.z;
MUL R0.z, R0, c[13];
ADD R1.z, R0, c[5].y;
ADD R2.z, R0.x, c[8].w;
MOV R2.w, c[5].y;
MUL R2.zw, R2, c[5];
ADD R0.x, R2.z, R2.w;
SIN R0.x, R0.x;
MUL R0.x, R0, c[6];
FRC R0.x, R0;
MUL R0.x, R0, c[10].z;
MUL R0.z, R0.x, R0.x;
MUL R0.z, R0, R1;
MUL R1.zw, R1.xyxy, R1.xyxy;
ADD R1.z, R1, R1.w;
SLT R1.w, R1.z, R0.z;
MUL R0.x, -R0, c[11].y;
ADD R0.x, R0, c[5].y;
MUL R0.x, R0, c[9].w;
ADD R0.z, R1, -R0;
ADD R1.x, R2, c[8].z;
MOV R1.y, c[5];
MUL R1.xy, R1, c[5].zwzw;
ADD R1.x, R1, R1.y;
SIN R2.y, R1.x;
MUL R2.y, R2, c[6].x;
FRC R2.z, R2.y;
ADD R1.x, R2, c[10].w;
MOV R1.y, c[5];
MUL R1.xy, R1, c[5].zwzw;
ADD R1.x, R1, R1.y;
SIN R1.y, R1.x;
MUL R2.y, R1, c[6].x;
FRC R3.x, R2.y;
MUL R1.x, R2.z, c[8].z;
ABS R1.y, R1.x;
MUL R2.w, R3.x, c[10].z;
MUL R3.y, fragment.texcoord[0], R2.w;
MAD R3.y, fragment.texcoord[0].x, R3.x, R3;
FLR R1.y, R1;
SLT R1.x, R1, c[5];
CMP R2.y, -R1.x, -R1, R1;
SLT R1.y, c[9].w, R3.x;
ABS R1.y, R1;
SLT R1.x, c[5].y, R2.y;
CMP R1.y, -R1, c[5].x, c[5];
MUL R2.w, R1.x, R1.y;
ADD R1.x, R2, c[10];
MOV R1.y, c[5];
MUL R1.xy, R1, c[5].zwzw;
ADD R1.x, R1, R1.y;
ADD R3.x, R3, -c[7].w;
ADD R1.y, R3, R3.x;
ABS R1.y, R1;
SIN R1.x, R1.x;
POW R3.y, R1.y, c[8].x;
MUL R1.x, R1, c[6];
FRC R1.y, R1.x;
ADD R1.x, -R3.y, c[8].w;
CMP R1.x, -R2.w, R1, R3.y;
MUL R3.x, R1.y, c[10].z;
MUL R2.w, fragment.texcoord[0].y, R3.x;
ADD R3.x, R1.y, -c[7].w;
MAD R2.w, fragment.texcoord[0].x, R1.y, R2;
ADD R2.w, R2, R3.x;
ABS R3.x, R2.w;
SLT R1.y, c[9].w, R1;
ABS R2.w, R1.y;
POW R1.y, R3.x, c[8].x;
CMP R3.x, -R2.w, c[5], c[5].y;
SLT R2.w, c[5].x, R2.y;
MUL R3.x, R2.w, R3;
ADD R3.y, -R1, c[8].w;
CMP R1.y, -R3.x, R3, R1;
ADD R3.y, R2.z, c[7].w;
MUL R3.y, R3, c[9];
ADD R2.w, -fragment.texcoord[0].x, c[5].y;
MUL R2.w, fragment.texcoord[0].x, R2;
ADD R3.x, -fragment.texcoord[0].y, c[5].y;
MUL R2.w, fragment.texcoord[0].y, R2;
MUL R2.w, R2, R3.x;
ADD R3.z, R3.y, c[6].w;
MUL R3.z, R2.w, R3;
MOV R3.x, c[7].w;
ADD R3.x, R3, -c[4];
ADD R3.y, -R3.x, c[5];
MUL R3.z, R3, c[9];
MUL R2.w, R2, c[9].z;
MAD R2.z, R2, c[9].x, R3;
MAD R1.x, R3.y, R1, R3;
ADD R0.x, R0, -c[4];
MAD R1.y, R1, R3, R3.x;
POW R2.w, R2.w, c[9].x;
ADD R2.z, R2, c[5].y;
MUL R2.z, R2, R2.w;
MUL R1.y, R2.z, R1;
CMP R1.y, -R2, R1, R2.z;
MUL R2.z, R1.y, R1.x;
ADD R1.x, -R2.y, c[5].y;
CMP R1.x, R1, R2.z, R1.y;
MUL R0.y, R1.x, R0;
CMP R1.x, -R0.w, R0.y, R1;
SLT R0.y, c[5], R0.w;
ABS R1.y, R1.w;
CMP R1.y, -R1, c[5].x, c[5];
MUL R0.y, R0, R1;
POW R1.y, R0.z, c[13].w;
ADD R0.z, R0.x, c[9].y;
CMP R1.y, -R0, R1, c[9].w;
ADD R1.z, -R0, c[5].y;
MAD R1.y, R1, R1.z, R0.z;
ADD R0.x, R2, c[6].y;
MOV R0.y, c[5];
MUL R0.xy, R0, c[5].zwzw;
ADD R0.y, R0.x, R0;
MOV R2.y, c[5];
MUL R2.xy, R2, c[5].zwzw;
ADD R0.x, R2, R2.y;
SIN R0.y, R0.y;
SIN R0.x, R0.x;
MUL R0.y, R0, c[6].x;
MUL R0.x, R0, c[6];
MOV R1.z, c[6].w;
FRC R0.y, R0;
FRC R0.x, R0;
MAD R0.xy, R0, c[6].z, fragment.texcoord[0];
TEX R0.xyz, R0, texture[0], 2D;
DP3 R0.z, R0, c[7];
ADD R0.x, R1.z, c[3];
MOV R0.y, c[3].x;
MUL R1.z, R0.y, c[7].w;
MUL R0.y, R0, c[8].x;
MOV R2.x, R0;
MOV R2.z, c[6].w;
ADD R2.y, R1.z, c[6].w;
MUL R2.xyz, R0.z, R2;
MUL R1.y, R1.x, R1;
ADD R0.w, -R0, c[5].y;
MUL R2.xyz, R2, c[2].x;
MOV R0.z, c[6].w;
ADD R0.y, R0, c[6].w;
MUL R0.xyz, R2, R0;
CMP R0.w, R0, R1.y, R1.x;
MUL R0.xyz, R0, c[2].x;
MUL result.color.xyz, R0, R0.w;
MOV result.color.w, c[5].y;
END
# 265 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_TimeX]
Float 1 [_Value]
Float 2 [_Value2]
Float 3 [_Value3]
Float 4 [_Value4]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
; 400 ALU, 1 TEX, 2 FLOW
dcl_2d s0
def c5, 1.00000000, 0.00000000, 12.98980045, 78.23300171
def c6, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c7, 43758.54687500, 23.00000000, 0.00200000, 0.69999999
def c8, 0.21259999, 0.71520001, 0.07220000, 8.00000000
def c9, 0.50000000, 0.69999999, 0.12500000, 0.30000001
def c10, 16.00000000, 0.40000001, 7.00000000, 0.20000000
def c11, 0.01000000, -0.50000000, 2.00000000, 24.00000000
def c12, 18.00000000, 8.00000000, -2.00000000, 6.00000000
def c13, -1.00000000, -0.01348047, 0.05747731, -0.12123910
def c14, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c15, 0.99998623, 0.50000000, 0.10000000, 1.00000000
def c16, 0.06250000, 50.00000000, 1.00000000, 25.00000000
dcl_texcoord0 v0.xy
mov r0.x, c0
mul r0.x, c1, r0
abs r0.y, r0.x
frc r0.z, r0.y
add r0.y, r0, -r0.z
cmp r1.w, r0.x, r0.y, -r0.y
mov r0.y, c5.x
add r0.x, r1.w, c10.z
mul r0.xy, r0, c5.zwzw
add r0.x, r0, r0.y
mad r0.x, r0, c6, c6.y
frc r0.z, r0.x
mad r1.y, r0.z, c6.z, c6.w
mov r0.y, c5.x
add r0.x, r1.w, c8.w
mul r0.xy, r0, c5.zwzw
add r1.x, r0, r0.y
sincos r0.xy, r1.y
mad r0.x, r1, c6, c6.y
frc r0.x, r0
mul r0.y, r0, c7.x
frc r1.x, r0.y
mad r1.y, r0.x, c6.z, c6.w
sincos r0.xy, r1.y
mul r0.x, r1, c11
mul r0.z, v0.y, r0.x
mul r0.x, r0.y, c7
frc r2.x, r0
mul r1.y, r2.x, c8.w
abs r1.z, r1.y
mad r0.y, v0.x, r1.x, r0.z
add r0.x, r1, c11.y
add r0.x, r0.y, r0
abs r2.z, r0.x
pow r0, r2.z, c9.z
frc r2.y, r1.z
add_pp r0.z, -r1.x, c10.w
add r0.y, r1.z, -r2
cmp r1.x, r1.y, r0.y, -r0.y
cmp_pp r0.z, r0, c5.x, c5.y
cmp r0.y, -r1.x, c5, c5.x
mul_pp r0.y, r0, r0.z
mov r0.z, c4.x
add r1.y, c6, -r0.z
add r0.z, -r0.x, c11
cmp r0.x, -r0.y, r0, r0.z
add r1.z, -r1.y, c5.x
mad r3.x, r0, r1.z, r1.y
add r0.y, r2.x, c6
mad r0.w, r0.y, c9, c9.y
add r0.x, -v0, c5
mul r0.x, v0, r0
add r0.y, -v0, c5.x
mul r0.x, v0.y, r0
mul r0.z, r0.x, r0.y
mul r0.w, r0.z, r0
mul r0.w, r0, c10.x
mov r0.y, c5.x
add r0.x, r1.w, c11.w
mul r0.xy, r0, c5.zwzw
add r0.y, r0.x, r0
mad r0.x, r2, c10.y, r0.w
add r3.y, r0.x, c5.x
mul r0.x, r0.z, c10
pow r2, r0.x, c10.y
mad r0.y, r0, c6.x, c6
frc r0.y, r0
mad r3.z, r0.y, c6, c6.w
sincos r0.xy, r3.z
mov r0.x, r2
mul r0.y, r0, c7.x
frc r0.z, r0.y
mul r0.x, r3.y, r0
mul r0.y, r0.x, r3.x
cmp r2.x, -r1, r0, r0.y
mul r0.w, r0.z, c11.x
mul r0.x, v0.y, r0.w
mad r0.x, v0, r0.z, r0
add r0.y, r0.z, c11
add r0.y, r0.x, r0
add r0.x, -r0.z, c10.w
abs r2.z, r0.y
cmp r2.y, r0.x, c5, c5.x
pow r0, r2.z, c9.z
abs_pp r0.z, r2.y
add r0.y, -r1.x, c5.x
cmp_pp r0.z, -r0, c5.x, c5.y
cmp r0.y, r0, c5, c5.x
mul_pp r0.y, r0, r0.z
mov r0.w, c5.x
add r0.z, r1.w, c12.x
mul r0.zw, r0, c5
add r0.w, r0.z, r0
add r0.z, -r0.x, c11
cmp r0.x, -r0.y, r0, r0.z
mad r0.x, r1.z, r0, r1.y
mad r0.w, r0, c6.x, c6.y
frc r0.y, r0.w
mul r1.y, r2.x, r0.x
mad r1.z, r0.y, c6, c6.w
sincos r0.xy, r1.z
add r0.x, -r1, c5
cmp r3.z, r0.x, r2.x, r1.y
mul r1.x, r0.y, c7
mov r0.y, c5.x
add r0.x, r1.w, c7.y
mul r0.zw, r0.xyxy, c5
add r0.z, r0, r0.w
mov r0.y, c5.x
mov r0.x, r1.w
mul r0.xy, r0, c5.zwzw
add r0.x, r0, r0.y
mad r0.y, r0.z, c6.x, c6
frc r0.y, r0
mad r0.x, r0, c6, c6.y
frc r0.x, r0
mad r1.y, r0.x, c6.z, c6.w
mad r1.z, r0.y, c6, c6.w
sincos r0.xy, r1.z
sincos r2.xy, r1.y
mul r0.x, r2.y, c7
frc r0.w, r1.x
mul r0.y, r0, c7.x
mad r0.w, r0, c12.y, c12.z
max r0.w, r0, c5.y
abs r2.x, r0.w
frc r2.y, r2.x
add r2.x, r2, -r2.y
frc r0.y, r0
frc r0.x, r0
mad r0.xy, r0, c7.z, v0
texld r0.xyz, r0, s0
dp3 r0.y, r0, c8
mov r0.z, c3.x
mad r1.y, r0.z, c9.x, c9
mov r0.x, c3
add r0.x, c7.w, r0
mov r1.x, r0
mov r1.z, c7.w
mul r1.xyz, r0.y, r1
mov r0.y, c3.x
mul r1.xyz, r1, c2.x
mov r0.z, c7.w
mad r0.y, r0, c9.z, c9
mul r0.xyz, r1, r0
cmp r3.w, r0, r2.x, -r2.x
mul r1.xyz, r0, c2.x
if_lt c5.y, r3.w
add r4.x, r1.w, c12.w
mov r4.y, c5.x
mul r0.zw, r4.xyxy, c5
add r0.x, r4, c5
mov r0.y, c5.x
mul r0.xy, r0, c5.zwzw
add r0.y, r0.x, r0
add r0.x, r0.z, r0.w
mad r0.y, r0, c6.x, c6
frc r0.y, r0
mad r0.x, r0, c6, c6.y
frc r0.x, r0
mad r2.x, r0.y, c6.z, c6.w
mad r3.x, r0, c6.z, c6.w
sincos r0.xy, r2.x
sincos r2.xy, r3.x
mul r0.x, r2.y, c7
mul r0.y, r0, c7.x
frc r0.z, r0.x
frc r0.w, r0.y
add r3.xy, r0.zwzw, -v0
rcp r0.x, r3.x
mul r0.w, r3.y, r0.x
abs r0.x, r0.w
max r0.y, r0.x, c5.x
rcp r2.x, r0.y
min r0.y, r0.x, c5.x
mul r0.y, r0, r2.x
mul r2.x, r0.y, r0.y
mad r2.y, r2.x, c13, c13.z
mad r2.y, r2, r2.x, c13.w
mad r2.y, r2, r2.x, c14.x
mad r2.y, r2, r2.x, c14
mad r2.x, r2.y, r2, c14.z
mul r0.y, r2.x, r0
add r2.x, -r0.y, c14.w
add r0.x, r0, c13
cmp r2.x, -r0, r0.y, r2
cmp r0.w, r0, r2.x, -r2.x
add r0.x, r4, c11.z
mov r0.y, c5.x
mul r0.xy, r0, c5.zwzw
add r0.x, r0, r0.y
mul r0.y, r0.w, r0.z
mad r0.x, r0, c6, c6.y
mad r0.y, r0, c15.x, c15
frc r0.y, r0
frc r0.x, r0
mad r0.x, r0, c6.z, c6.w
sincos r2.xy, r0.x
mad r4.x, r0.y, c6.z, c6.w
sincos r0.xy, r4.x
mul r0.x, r2.y, c7
frc r0.w, r0.x
mad r0.z, r0.y, c15, c15.w
mul r0.xy, r3, r3
add r0.y, r0.x, r0
mul r0.w, r0, c11.x
mul r0.x, r0.w, r0.w
mad r2.x, -r0, r0.z, r0.y
mad r0.w, -r0, c16.y, c16.z
cmp r2.x, r2, c5.y, c5
mul r2.z, r0.w, c10.w
mad r2.y, -r0.x, r0.z, r0
pow r0, r2.y, c16.x
add r0.y, r2.z, -c4.x
add r0.y, r0, c9.w
abs_pp r2.x, r2
add r0.z, -r0.y, c5.x
cmp r0.x, -r2, r0, c10.w
mad r0.x, r0, r0.z, r0.y
mul r3.z, r3, r0.x
endif
if_lt c5.x, r3.w
add r4.x, r1.w, c16.w
mov r4.y, c5.x
mul r0.zw, r4.xyxy, c5
mov r0.y, c5.x
add r0.x, r4, c5
mul r0.xy, r0, c5.zwzw
add r0.y, r0.x, r0
add r0.x, r0.z, r0.w
mad r0.y, r0, c6.x, c6
frc r0.y, r0
mad r0.x, r0, c6, c6.y
frc r0.x, r0
mad r2.x, r0.y, c6.z, c6.w
mad r1.w, r0.x, c6.z, c6
sincos r0.xy, r2.x
sincos r2.xy, r1.w
mul r0.x, r2.y, c7
mul r0.y, r0, c7.x
frc r0.x, r0
frc r0.y, r0
add r3.xy, r0, -v0
rcp r0.y, r3.x
mul r0.y, r3, r0
abs r0.z, r0.y
max r0.w, r0.z, c5.x
rcp r1.w, r0.w
min r0.w, r0.z, c5.x
mul r0.w, r0, r1
mul r1.w, r0, r0
mad r2.x, r1.w, c13.y, c13.z
mad r2.x, r2, r1.w, c13.w
mad r2.x, r2, r1.w, c14
mad r2.x, r2, r1.w, c14.y
mad r1.w, r2.x, r1, c14.z
mul r0.w, r1, r0
add r1.w, -r0, c14
add r0.z, r0, c13.x
cmp r1.w, -r0.z, r0, r1
cmp r1.w, r0.y, r1, -r1
mov r0.w, c5.x
add r0.z, r4.x, c11
mul r0.zw, r0, c5
add r0.y, r0.z, r0.w
mul r0.z, r1.w, r0.x
mad r0.x, r0.y, c6, c6.y
mad r0.y, r0.z, c15.x, c15
frc r0.y, r0
frc r0.x, r0
mad r0.x, r0, c6.z, c6.w
sincos r2.xy, r0.x
mad r1.w, r0.y, c6.z, c6
sincos r0.xy, r1.w
mad r0.x, r0.y, c15.z, c15.w
mul r0.z, r2.y, c7.x
frc r0.y, r0.z
mul r0.zw, r3.xyxy, r3.xyxy
add r0.w, r0.z, r0
mul r0.y, r0, c11.x
mul r0.z, r0.y, r0.y
mad r1.w, -r0.z, r0.x, r0
mad r0.y, -r0, c16, c16.z
cmp r1.w, r1, c5.y, c5.x
mul r2.y, r0, c10.w
mad r2.x, -r0.z, r0, r0.w
pow r0, r2.x, c16.x
add r0.y, r2, -c4.x
add r0.y, r0, c9.w
abs_pp r1.w, r1
add r0.z, -r0.y, c5.x
cmp r0.x, -r1.w, r0, c10.w
mad r0.x, r0, r0.z, r0.y
mul r3.z, r3, r0.x
endif
mul oC0.xyz, r1, r3.z
mov oC0.w, c5.x
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 16 [_TimeX]
Float 20 [_Value]
Float 24 [_Value2]
Float 28 [_Value3]
Float 32 [_Value4]
BindCB  "$Globals" 0
"ps_4_0
eefiecedlepjonhloccbhppcepmgmlkhkemlhkmpabaaaaaamebiaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaadadaaaafjaaaaaaaaaaaaaaabaaaaaa
adaaaaaaabaaaaaaapaaaaaagfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafeeffiedepepfceeaafdfgfpfaepfdejfeejepeoaaedepemepfcaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoibhaaaaeaaaaaaa
pkafaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaaaaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacafaaaaaadiaaaaajbcaabaaaaaaaaaaabkiacaaa
aaaaaaaaabaaaaaaakiacaaaaaaaaaaaabaaaaaaedaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaiadpapaaaaak
bcaabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaadjngepebemhhjmecaaaaaaaa
aaaaaaaaenaaaaagbcaabaaaabaaaaaaaanaaaaaakaabaaaabaaaaaadiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaimoockehbkaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaaaaaaaaakmcaabaaaaaaaaaaaagaabaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaliebaaaaaaebapaaaaakecaabaaaaaaaaaaa
ggakbaaaaaaaaaaaaceaaaaadjngepebemhhjmecaaaaaaaaaaaaaaaaenaaaaag
ecaabaaaaaaaaaaaaanaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaimoockehbkaaaaafccaabaaaabaaaaaackaabaaa
aaaaaaaadcaaaaamdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaagpbcaddl
gpbcaddlaaaaaaaaaaaaaaaaegbabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaabaaaaaakbcaabaaa
abaaaaaaaceaaaaanaldfjdofjbhdhdpjinnjddnaaaaaaaaegacbaaaabaaaaaa
dgaaaaagccaabaaaabaaaaaackiacaaaaaaaaaaaabaaaaaadcaaaabahcaabaaa
acaaaaaapgiocaaaaaaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaaadpaaaaiadp
aaaaaaaaaceaaaaadddddddpdddddddpaaaaaaaaaaaaaaaadiaaaaahhcaabaaa
acaaaaaaagabbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaidcaabaaaacaaaaaa
egaabaaaacaaaaaakgikcaaaaaaaaaaaabaaaaaadcaaaabamcaabaaaabaaaaaa
pgipcaaaaaaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaado
aceaaaaaaaaaaaaaaaaaaaaadddddddpdddddddpdiaaaaahhcaabaaaabaaaaaa
ogaibaaaabaaaaaaegacbaaaacaaaaaadgaaaaagbcaabaaaacaaaaaackiacaaa
aaaaaaaaabaaaaaadgaaaaafecaabaaaacaaaaaaabeaaaaaehobpkdodiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaagacbaaaacaaaaaaapaaaaakecaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaadjngepebemhhjmecaaaaaaaaaaaaaaaa
enaaaaagecaabaaaaaaaaaaaaanaaaaackaabaaaaaaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaimoockehbkaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaaaaaaaaldcaabaaaacaaaaaaegbabaiaebaaaaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
akaabaaaacaaaaaaakbabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaabkbabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaacaaaaaa
dkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiaebaaaaaaahicaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaadp
dcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaajkjjjjdoabeaaaaa
dddddddpdiaaaaakmcaabaaaacaaaaaakgakbaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaamnmmmmdoaaaaaaebdcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaabaaaaaackaabaaaacaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaabaaaaaaakbabaaaaaaaaaaa
abeaaaaaaaaaiaebdiaaaaahicaabaaaabaaaaaaakaabaaaacaaaaaadkaabaaa
abaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaabkbabaaaaaaaaaaa
diaaaaahicaabaaaabaaaaaabkaabaaaacaaaaaadkaabaaaabaaaaaacpaaaaaf
icaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaamnmmmmdobjaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaablaaaaaf
icaabaaaabaaaaaadkaabaaaacaaaaaaccaaaaakdcaabaaaacaaaaaaaceaaaaa
aaaaaaaaabaaaaaaaaaaaaaaaaaaaaaapgapbaaaabaaaaaaaaaaaaakpcaabaaa
adaaaaaaegaebaaaaaaaaaaaaceaaaaaaaaaoaeaaaaaaaaaaaaamaebaaaaaaaa
apaaaaakicaabaaaabaaaaaaegaabaaaadaaaaaaaceaaaaadjngepebemhhjmec
aaaaaaaaaaaaaaaaenaaaaagicaabaaaabaaaaaaaanaaaaadkaabaaaabaaaaaa
diaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaimoockehbkaaaaaf
ccaabaaaadaaaaaadkaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaabkaabaaa
adaaaaaaabeaaaaaaknhcddmaaaaaaahecaabaaaacaaaaaabkaabaaaadaaaaaa
abeaaaaaaaaaaalpdbaaaaahicaabaaaacaaaaaaabeaaaaamnmmemdobkaabaaa
adaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaabkbabaaaaaaaaaaa
dcaaaaajicaabaaaabaaaaaabkaabaaaadaaaaaaakbabaaaaaaaaaaadkaabaaa
abaaaaaaaaaaaaahicaabaaaabaaaaaackaabaaaacaaaaaadkaabaaaabaaaaaa
cpaaaaagicaabaaaabaaaaaadkaabaiaibaaaaaaabaaaaaadiaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaadobjaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaaaaaaaaaiecaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaaaeadhaaaaajicaabaaaabaaaaaadkaabaaaacaaaaaadkaabaaa
abaaaaaackaabaaaacaaaaaaaaaaaaajecaabaaaacaaaaaaakiacaiaebaaaaaa
aaaaaaaaacaaaaaaabeaaaaaaaaaaadpaaaaaaaiicaabaaaacaaaaaackaabaia
ebaaaaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaajicaabaaaabaaaaaadkaabaaa
abaaaaaadkaabaaaacaaaaaackaabaaaacaaaaaadiaaaaahicaabaaaabaaaaaa
dkaabaaaaaaaaaaadkaabaaaabaaaaaadhaaaaajicaabaaaaaaaaaaaakaabaaa
acaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaaapaaaaakicaabaaaabaaaaaa
ogakbaaaadaaaaaaaceaaaaadjngepebemhhjmecaaaaaaaaaaaaaaaaenaaaaag
icaabaaaabaaaaaaaanaaaaadkaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaa
dkaabaaaabaaaaaaabeaaaaaimoockehbkaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaaabaaaaaaabeaaaaaaknhcddm
aaaaaaahecaabaaaadaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaalpdbaaaaah
icaabaaaadaaaaaaabeaaaaamnmmemdodkaabaaaabaaaaaadiaaaaahbcaabaaa
acaaaaaaakaabaaaacaaaaaabkbabaaaaaaaaaaadcaaaaajicaabaaaabaaaaaa
dkaabaaaabaaaaaaakbabaaaaaaaaaaaakaabaaaacaaaaaaaaaaaaahicaabaaa
abaaaaaackaabaaaadaaaaaadkaabaaaabaaaaaacpaaaaagicaabaaaabaaaaaa
dkaabaiaibaaaaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaaadobjaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaaaaaaaaai
bcaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaaaeadhaaaaaj
icaabaaaabaaaaaadkaabaaaadaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaa
dcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaaacaaaaaackaabaaa
acaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaa
dhaaaaajicaabaaaaaaaaaaabkaabaaaacaaaaaadkaabaaaabaaaaaadkaabaaa
aaaaaaaaaaaaaaakdcaabaaaacaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaajaeb
aaaaaaaaaaaaaaaaaaaaaaaaapaaaaakicaabaaaabaaaaaaegaabaaaacaaaaaa
aceaaaaadjngepebemhhjmecaaaaaaaaaaaaaaaaenaaaaagicaabaaaabaaaaaa
aanaaaaadkaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaimoockehbkaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaaj
icaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebabeaaaaaaaaaaama
deaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaaablaaaaaf
icaabaaaabaaaaaadkaabaaaabaaaaaaccaaaaakdcaabaaaacaaaaaaaceaaaaa
aaaaaaaaabaaaaaaaaaaaaaaaaaaaaaapgapbaaaabaaaaaabpaaaeadakaabaaa
acaaaaaaaaaaaaakfcaabaaaacaaaaaaagabbaaaaaaaaaaaaceaaaaaaaaamaea
aaaaaaaaaaaaaaaaaaaaaaaaapaaaaakicaabaaaabaaaaaaigaabaaaacaaaaaa
aceaaaaadjngepebemhhjmecaaaaaaaaaaaaaaaaenaaaaagicaabaaaabaaaaaa
aanaaaaadkaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaimoockehbkaaaaafbcaabaaaadaaaaaadkaabaaaabaaaaaadiaaaaah
icaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaaknhcddmaaaaaaaifcaabaaa
acaaaaaaagabbaaaadaaaaaaagbbbaiaebaaaaaaaaaaaaaaaoaaaaahicaabaaa
acaaaaaackaabaaaacaaaaaaakaabaaaacaaaaaaddaaaaaiccaabaaaadaaaaaa
dkaabaiaibaaaaaaacaaaaaaabeaaaaaaaaaiadpdeaaaaaiecaabaaaadaaaaaa
dkaabaiaibaaaaaaacaaaaaaabeaaaaaaaaaiadpaoaaaaakecaabaaaadaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpckaabaaaadaaaaaadiaaaaah
ccaabaaaadaaaaaackaabaaaadaaaaaabkaabaaaadaaaaaadiaaaaahecaabaaa
adaaaaaabkaabaaaadaaaaaabkaabaaaadaaaaaadcaaaaajicaabaaaadaaaaaa
ckaabaaaadaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajicaabaaa
adaaaaaackaabaaaadaaaaaadkaabaaaadaaaaaaabeaaaaaochgdidodcaaaaaj
icaabaaaadaaaaaackaabaaaadaaaaaadkaabaaaadaaaaaaabeaaaaaaebnkjlo
dcaaaaajecaabaaaadaaaaaackaabaaaadaaaaaadkaabaaaadaaaaaaabeaaaaa
diphhpdpdiaaaaahicaabaaaadaaaaaackaabaaaadaaaaaabkaabaaaadaaaaaa
dbaaaaaibcaabaaaaeaaaaaaabeaaaaaaaaaiadpdkaabaiaibaaaaaaacaaaaaa
dcaaaaajicaabaaaadaaaaaadkaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapmjdpabaaaaahicaabaaaadaaaaaaakaabaaaaeaaaaaadkaabaaaadaaaaaa
dcaaaaajccaabaaaadaaaaaabkaabaaaadaaaaaackaabaaaadaaaaaadkaabaaa
adaaaaaaddaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadp
dbaaaaaiicaabaaaacaaaaaadkaabaaaacaaaaaadkaabaiaebaaaaaaacaaaaaa
dhaaaaakicaabaaaacaaaaaadkaabaaaacaaaaaabkaabaiaebaaaaaaadaaaaaa
bkaabaaaadaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaa
diaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaciapmjeaenaaaaag
icaabaaaacaaaaaaaanaaaaadkaabaaaacaaaaaadcaaaaajicaabaaaacaaaaaa
dkaabaaaacaaaaaaabeaaaaamnmmmmdnabeaaaaaaaaaiadpdiaaaaahbcaabaaa
adaaaaaadkaabaaaabaaaaaadkaabaaaacaaaaaaapaaaaahbcaabaaaacaaaaaa
igaabaaaacaaaaaaigaabaaaacaaaaaadbaaaaahecaabaaaacaaaaaaakaabaaa
acaaaaaaakaabaaaadaaaaaadcaaaaakicaabaaaabaaaaaadkaabaiaebaaaaaa
abaaaaaadkaabaaaacaaaaaaakaabaaaacaaaaaacpaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
aaaaiadnbjaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadhaaaaajicaabaaa
abaaaaaackaabaaaacaaaaaaabeaaaaamnmmemdodkaabaaaabaaaaaadcaaaaak
ecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaa
aaaaiadpdcaaaaalecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaamnmmemdo
akiacaiaebaaaaaaaaaaaaaaacaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaajkjjjjdoaaaaaaaibcaabaaaacaaaaaackaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdcaaaaajecaabaaaaaaaaaaadkaabaaaabaaaaaa
akaabaaaacaaaaaackaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaackaabaaa
aaaaaaaadkaabaaaaaaaaaaabfaaaaabbpaaaeadbkaabaaaacaaaaaaaaaaaaak
pcaabaaaacaaaaaaegaebaaaaaaaaaaaaceaaaaaaaaamiebaaaaaaaaaaaanaeb
aaaaaaaaapaaaaakecaabaaaaaaaaaaaegaabaaaacaaaaaaaceaaaaadjngepeb
emhhjmecaaaaaaaaaaaaaaaaenaaaaagecaabaaaaaaaaaaaaanaaaaackaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaimoockeh
bkaaaaafbcaabaaaacaaaaaackaabaaaaaaaaaaaapaaaaakecaabaaaaaaaaaaa
ogakbaaaacaaaaaaaceaaaaadjngepebemhhjmecaaaaaaaaaaaaaaaaenaaaaag
ecaabaaaaaaaaaaaaanaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaimoockehbkaaaaafccaabaaaacaaaaaackaabaaa
aaaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaanieb
aaaaaaaaaaaaaaaaaaaaaaaaapaaaaakbcaabaaaaaaaaaaaegaabaaaaaaaaaaa
aceaaaaadjngepebemhhjmecaaaaaaaaaaaaaaaaenaaaaagbcaabaaaaaaaaaaa
aanaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaimoockehbkaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaknhcddmaaaaaaaigcaabaaa
acaaaaaaagabbaaaacaaaaaaagbbbaiaebaaaaaaaaaaaaaaaoaaaaahecaabaaa
aaaaaaaackaabaaaacaaaaaabkaabaaaacaaaaaaddaaaaaiicaabaaaabaaaaaa
ckaabaiaibaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaaiicaabaaaacaaaaaa
ckaabaiaibaaaaaaaaaaaaaaabeaaaaaaaaaiadpaoaaaaakicaabaaaacaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaacaaaaaadiaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaaacaaaaaadiaaaaahicaabaaa
acaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaajbcaabaaaadaaaaaa
dkaabaaaacaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajbcaabaaa
adaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaaochgdidodcaaaaaj
bcaabaaaadaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaaaebnkjlo
dcaaaaajicaabaaaacaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaa
diphhpdpdiaaaaahbcaabaaaadaaaaaadkaabaaaabaaaaaadkaabaaaacaaaaaa
dbaaaaaiccaabaaaadaaaaaaabeaaaaaaaaaiadpckaabaiaibaaaaaaaaaaaaaa
dcaaaaajbcaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapmjdpabaaaaahbcaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaa
dcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaaacaaaaaaakaabaaa
adaaaaaaddaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadp
dbaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
dhaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaacaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaciapmjeaenaaaaag
ecaabaaaaaaaaaaaaanaaaaackaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaamnmmmmdnabeaaaaaaaaaiadpdiaaaaahicaabaaa
abaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaaapaaaaahbcaabaaaacaaaaaa
jgafbaaaacaaaaaajgafbaaaacaaaaaadbaaaaahicaabaaaabaaaaaaakaabaaa
acaaaaaadkaabaaaabaaaaaadcaaaaakccaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaackaabaaaaaaaaaaaakaabaaaacaaaaaacpaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaiadnbjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadhaaaaajccaabaaa
aaaaaaaadkaabaaaabaaaaaaabeaaaaamnmmemdobkaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaa
aaaaiadpdcaaaaalbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaamnmmemdo
akiacaiaebaaaaaaaaaaaaaaacaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaajkjjjjdoaaaaaaaiecaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdcaaaaajbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaa
aaaaaaaadkaabaaaaaaaaaaabfaaaaabdiaaaaahhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadp
doaaaaab"
}
}
 }
}
}