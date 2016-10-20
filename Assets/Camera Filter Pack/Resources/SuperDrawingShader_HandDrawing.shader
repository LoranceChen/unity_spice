Shader "SuperDrawingShader/HandDrawing" {
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
Float 2 [_BackGroundX]
Float 3 [_BackGroundY]
Float 4 [_Inverse]
Float 5 [_DotSize]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MainTex2] 2D 1
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 111 ALU, 6 TEX
PARAM c[13] = { program.local[0..5],
		{ 1, 0.1, 0.22727272, 0.0125 },
		{ 200, 0.00390625, 0.75, 0.039999999 },
		{ 0.0019, 2, 0, -1 },
		{ 0.1125, 0.22125, 0.041249998, 0.25 },
		{ 2.6666667, 0, 0.125, 0.875 },
		{ 0.625, 0.5, 0.375, 180 },
		{ 150 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.x, c[8];
MUL R2.z, R0.x, c[5].x;
MOV R2.w, -R2.z;
MOV R0.y, R2.z;
MOV R0.x, -R2.z;
ADD R0.zw, fragment.texcoord[0].xyxy, R0.xyxy;
TEX R1, R0.zwzw, texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], R2.zwzw;
DP4 R1.x, R1, c[9];
TEX R0, R0, texture[0], 2D;
DP4 R1.y, R0, c[9];
ADD R0.xy, fragment.texcoord[0], -R2.z;
TEX R0, R0, texture[0], 2D;
MAD R1.w, R1.x, c[8].y, R1.x;
MOV R2.z, c[11].w;
MUL R3.y, R2.z, c[0].x;
DP4 R0.y, R0, c[9];
ADD R1.z, R1.y, R1.x;
ADD R1.w, R1.x, R1;
ADD R0.z, -R0.y, R1.w;
MAD R0.x, R1.y, c[8].y, R1.z;
ADD R0.x, R0, -R0.y;
MAD R0.z, -R0.y, c[8].y, R0;
ADD R0.y, -R1, R0.z;
MAD R0.x, -R1.y, c[8].y, R0;
ADD R0.x, R0, -R1;
MUL R0.y, R0, R0;
MAD R0.x, R0, R0, R0.y;
SLT R0.x, c[7].w, R0;
MOV R1.w, c[6].x;
ABS R0.x, R0;
CMP R1.x, -R0, c[8].z, R1.w;
TEX R0, fragment.texcoord[0], texture[0], 2D;
CMP R1.x, -R1, c[8].z, c[8].w;
ADD R0.xyz, R0, c[1].x;
ADD R0.xyz, R0, R1.x;
ADD R0.x, R0, R0.y;
ADD R0.x, R0, R0.z;
MUL R0.x, R0, c[10];
FLR R0.z, R0.x;
MUL R0.y, R0.z, c[10].z;
ADD R0.x, R0.y, -c[9].w;
ABS R3.x, R0;
MAD R1.z, R0, c[10], -c[10];
MOV R0.x, c[7];
MUL R0.x, R0, c[0];
SIN R0.x, R0.x;
FLR R0.x, R0;
MUL R0.x, R0, c[7].y;
MAD R1.xy, fragment.texcoord[0], c[6].z, c[6].w;
ADD R2.z, R0.x, c[11].y;
MOV R2.w, c[11].y;
ADD R2.zw, R1.xyxy, R2;
CMP R2.zw, -R1.z, R2.xyxy, R2;
SIN R3.y, R3.y;
FLR R1.z, R3.y;
MUL R1.z, R1, c[7].y;
MOV R3.y, c[12].x;
ADD R2.x, R1.z, c[9].w;
MOV R2.y, c[11];
ADD R2.xy, R1, R2;
CMP R2.zw, -R3.x, R2, R2.xyxy;
MUL R3.y, R3, c[0].x;
SIN R2.x, R3.y;
FLR R2.x, R2;
ADD R3.z, R0.y, -c[11];
MOV R2.y, c[11];
MUL R2.x, R2, c[7].y;
ADD R3.xy, R1, R2;
ABS R2.y, R3.z;
CMP R3.xy, -R2.y, R2.zwzw, R3;
ADD R2.y, R0, -c[11];
ADD R2.z, R0.x, c[7];
MOV R2.w, c[7].z;
ADD R2.zw, R1.xyxy, R2;
ABS R2.y, R2;
CMP R2.zw, -R2.y, R3.xyxy, R2;
ADD R2.y, R0, -c[7].z;
ADD R3.x, R1.z, c[11].y;
ABS R1.z, R2.y;
ADD R0.y, R0, -c[11].x;
MOV R3.y, c[7].z;
ADD R3.xy, R1, R3;
ABS R0.y, R0;
CMP R2.zw, -R0.y, R2, R3.xyxy;
MOV R0.y, c[7].z;
ADD R0.xy, R1, R0;
MAD R0.z, R0, c[10], -c[10].w;
MOV R2.y, c[7].z;
ADD R2.x, R2, c[9].w;
ADD R2.xy, R1, R2;
CMP R2.xy, -R1.z, R2.zwzw, R2;
CMP R2.xy, R0.z, R2, R0;
ADD R0.z, R0.w, -c[6].y;
CMP R0.xy, R0.z, R0, R2;
TEX R0.xyz, R0, texture[1], 2D;
ADD R0.w, -R1, c[4].x;
RCP R2.x, R0.x;
RCP R2.y, R0.y;
MOV R2.z, c[2].x;
MOV R2.w, c[3].x;
ADD R1.xy, R1, R2.zwzw;
RCP R2.z, R0.z;
TEX R1.xyz, R1, texture[1], 2D;
MUL R2.xyz, R1, R2;
ABS R0.w, R0;
CMP R0.xyz, -R0.w, R0, R2;
MUL R1.xyz, R0, R1;
ABS R0.w, c[4].x;
CMP result.color.xyz, -R0.w, R0, R1;
MOV result.color.w, c[6].x;
END
# 111 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_Time]
Float 1 [_Distortion]
Float 2 [_BackGroundX]
Float 3 [_BackGroundY]
Float 4 [_Inverse]
Float 5 [_DotSize]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MainTex2] 2D 1
"ps_3_0
; 132 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c6, 0.22727272, 0.01250000, -1.00000000, -0.10000000
def c7, 0.00190000, 2.00000000, -0.04000000, 2.66666675
def c8, 0.11250000, 0.22125000, 0.04125000, 0.25000000
def c9, 0.00000000, -1.00000000, 0.12500000, -0.87500000
def c10, 31.83098221, 0.50000000, 6.28318501, -3.14159298
def c11, 0.00390625, 0.75000000, 0.12500000, -0.75000000
def c12, 23.87323570, 0.50000000, 0.12500000, -0.62500000
def c13, 28.64788246, 0.50000000, 0.00390625, 0.25000000
def c14, 0.12500000, -0.50000000, -0.37500000, -0.25000000
def c15, 1.00000000, 0, 0, 0
dcl_texcoord0 v0.xy
mov r0.x, c5
mul r2.z, c7.x, r0.x
mov r2.w, -r2.z
mov r0.y, r2.z
mov r0.x, -r2.z
add r1.xy, v0, r0
texld r1, r1, s0
dp4 r1.x, r1, c8
add r0.xy, v0, r2.zwzw
texld r0, r0, s0
dp4 r1.y, r0, c8
add r0.xy, v0, -r2.z
texld r0, r0, s0
mad r1.w, r1.x, c7.y, r1.x
dp4 r0.y, r0, c8
add r1.z, r1.y, r1.x
add r1.w, r1.x, r1
add r0.z, -r0.y, r1.w
mad r0.x, r1.y, c7.y, r1.z
add r0.x, r0, -r0.y
mad r0.z, -r0.y, c7.y, r0
add r0.y, -r1, r0.z
mad r0.x, -r1.y, c7.y, r0
add r0.x, r0, -r1
mul r0.y, r0, r0
mad r0.x, r0, r0, r0.y
add_pp r1.x, r0, c7.z
texld r0, v0, s0
cmp r1.x, -r1, c9, c9.y
add r0.xyz, r0, c1.x
add r0.xyz, r0, r1.x
add r0.x, r0, r0.y
add r0.x, r0, r0.z
mul r0.x, r0, c7.w
frc r0.y, r0.x
add r0.z, r0.x, -r0.y
mad r0.y, r0.z, c14.x, c14.w
mov r1.x, c0
mad r0.x, r1, c10, c10.y
frc r0.x, r0
mad r0.x, r0, c10.z, c10.w
sincos r1.xy, r0.x
abs r2.w, r0.y
mov r0.x, c0
mad r0.y, r0.x, c13.x, c13
frc r0.x, r1.y
add r0.x, r1.y, -r0
frc r0.y, r0
mad r0.y, r0, c10.z, c10.w
mul r2.z, r0.x, c11.x
sincos r1.xy, r0.y
add r1.z, r2, c10.y
mad r0.xy, v0, c6.x, c6.y
mov r1.w, c10.y
mad r3.x, r0.z, c9.z, -c9.z
add r1.zw, r0.xyxy, r1
cmp r1.zw, -r3.x, r1, r2.xyxy
frc r1.x, r1.y
add r3.x, r1.y, -r1
mov r1.y, c0.x
mad r2.x, r1.y, c12, c12.y
frc r2.x, r2
mad r3.y, r2.x, c10.z, c10.w
mad r1.x, r3, c13.z, c13.w
mov r1.y, c10
add r1.xy, r0, r1
cmp r2.xy, -r2.w, r1, r1.zwzw
sincos r1.xy, r3.y
mad r1.z, r0, c14.x, c14
frc r1.x, r1.y
add r1.x, r1.y, -r1
mad r2.w, r0.z, c14.x, c14.y
abs r3.y, r1.z
mov r1.y, c10
mul r1.x, r1, c11
add r1.zw, r0.xyxy, r1.xyxy
cmp r2.xy, -r3.y, r1.zwzw, r2
abs r1.y, r2.w
add r1.z, r2, c11.y
mov r1.w, c11.y
add r1.zw, r0.xyxy, r1
cmp r1.zw, -r1.y, r1, r2.xyxy
mad r2.x, r0.z, c12.z, c12.w
mad r1.y, r0.z, c11.z, c11.w
abs r2.w, r2.x
mad r0.z, r0, c9, c9.w
mov r2.y, c11
mad r2.x, r3, c13.z, c13.y
add r2.xy, r0, r2
cmp r1.zw, -r2.w, r2.xyxy, r1
abs r2.x, r1.y
mov r1.y, c11
add r1.x, r1, c8.w
add r1.xy, r0, r1
cmp r1.xy, -r2.x, r1, r1.zwzw
mov r2.w, c11.y
add r1.zw, r0.xyxy, r2
cmp r1.xy, r0.z, r1.zwzw, r1
add r0.z, r0.w, c6.w
cmp r1.xy, r0.z, r1, r1.zwzw
texld r1.xyz, r1, s1
rcp r2.x, r1.x
rcp r2.y, r1.y
rcp r2.z, r1.z
mov r0.w, c3.x
mov r0.z, c2.x
add r0.xy, r0, r0.zwzw
texld r0.xyz, r0, s1
mov r0.w, c4.x
add r0.w, c6.z, r0
mul r2.xyz, r0, r2
abs r0.w, r0
cmp r1.xyz, -r0.w, r2, r1
mul r2.xyz, r0, r1
abs r0.x, c4
cmp oC0.xyz, -r0.x, r2, r1
mov oC0.w, c15.x
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MainTex2] 2D 1
ConstBuffer "$Globals" 48
Float 20 [_Distortion]
Float 24 [_BackGroundX]
Float 28 [_BackGroundY]
Float 32 [_Inverse]
Float 36 [_DotSize]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedcfkhhlbgjanmhglhmecicfnmbhphapahabaaaaaacaakaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaadadaaaafjaaaaaaaaaaaaaaabaaaaaa
adaaaaaaabaaaaaaapaaaaaagfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafeeffiedepepfceeaafdfgfpfaepfdejfeejepeoaaedepemepfcaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefceeajaaaaeaaaaaaa
fbacaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
dcbabaaaaaaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaadcaaaaal
bcaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaaacaaaaaaabeaaaaagmajpjdk
akbabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaabkiacaaaaaaaaaaaacaaaaaa
abeaaaaagmajpjdkbkbabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaabbaaaaakbcaabaaaaaaaaaaa
egaobaaaaaaaaaaaaceaaaaaghggogdnfmipgcdomcpfcidnaaaaiadodcaaaaak
ecaabaaaabaaaaaabkiacaaaaaaaaaaaacaaaaaaabeaaaaagmajpjdkakbabaaa
aaaaaaaadcaaaaaolcaabaaaabaaaaaafgifcaiaebaaaaaaaaaaaaaaacaaaaaa
aceaaaaagmajpjdkgmajpjdkaaaaaaaagmajpjdkegbebaaaaaaaaaaaefaaaaaj
pcaabaaaacaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaabbaaaaakccaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaaghggogdn
fmipgcdomcpfcidnaaaaiadobbaaaaakecaabaaaaaaaaaaaegaobaaaacaaaaaa
aceaaaaaghggogdnfmipgcdomcpfcidnaaaaiadoaaaaaaahicaabaaaaaaaaaaa
akaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajicaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaaaeadkaabaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaaeadkaabaaaaaaaaaaaaaaaaaai
icaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaeabkaabaiaebaaaaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaaaeaakaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaaaaaaaaadbaaaaahbcaabaaaaaaaaaaaabeaaaaaaknhcddn
akaabaaaaaaaaaaaabaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaialpefaaaaajpcaabaaaabaaaaaaegbabaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaaaaaaaaiocaabaaaaaaaaaaaagajbaaaabaaaaaafgifcaaa
aaaaaaaaabaaaaaadbaaaaahbcaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
mnmmmmdnaaaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaa
aaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaah
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaklkkckeaebaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabnaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaoaeadmaaaaahccaabaaaaaaaaaaaakaabaaaabaaaaaabkaabaaaaaaaaaaa
biaaaaahecaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaamaeabiaaaaak
pcaabaaaabaaaaaaagaabaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaeaeaaaaaiaea
aaaakaeadiaaaaalhcaabaaaacaaaaaaagiacaaaabaaaaaaaaaaaaaaaceaaaaa
aaaaeiedaaaadeedaaaabgedaaaaaaaaenaaaaaghcaabaaaacaaaaaaaanaaaaa
egacbaaaacaaaaaaebaaaaafhcaabaaaacaaaaaaegacbaaaacaaaaaadcaaaaap
hcaabaaaadaaaaaaagbbbaaaaaaaaaaaaceaaaaacolkgidocolkgidocolkgido
aaaaaaaaaceaaaaamnmmemdmmnmmemdmaaaaaaaaaaaaaaaadcaaaaamdcaabaaa
aeaaaaaaegaabaaaacaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaaaaaaaaaaaaa
agaabaaaadaaaaaadiaaaaakfcaabaaaacaaaaaaagacbaaaacaaaaaaaceaaaaa
aaaaiadlaaaaaaaaaaaaiadlaaaaaaaadiaaaaahecaabaaaaeaaaaaabkbabaaa
aaaaaaaaabeaaaaacolkgidoaaaaaaakpcaabaaaafaaaaaaigajbaaaaeaaaaaa
aceaaaaaaaaaaadpddddaddpaaaaiadoddddaddpaaaaaaakpcaabaaaaeaaaaaa
igajbaaaaeaaaaaaaceaaaaaaaaaeadpddddeddpaaaaaadpddddeddpdhaaaaaj
jcaabaaaaaaaaaaaagaabaaaabaaaaaakgaobaaaafaaaaaaagaebaaaafaaaaaa
dgaaaaaikcaabaaaacaaaaaaaceaaaaaaaaaaaaaddddeddpaaaaaaaaddddaddp
aaaaaaahdcaabaaaafaaaaaaogakbaaaacaaaaaajgafbaaaadaaaaaadhaaaaaj
jcaabaaaaaaaaaaafgafbaaaabaaaaaaagaebaaaafaaaaaaagambaaaaaaaaaaa
dhaaaaajjcaabaaaaaaaaaaakgakbaaaabaaaaaaagaebaaaaeaaaaaaagambaaa
aaaaaaaadhaaaaajjcaabaaaaaaaaaaapgapbaaaabaaaaaakgaobaaaaeaaaaaa
agambaaaaaaaaaaadiaaaaahecaabaaaafaaaaaabkbabaaaaaaaaaaaabeaaaaa
colkgidoaaaaaaakdcaabaaaabaaaaaaigaabaaaafaaaaaaaceaaaaaaaaaiado
ddddeddpaaaaaaaaaaaaaaaadhaaaaajfcaabaaaaaaaaaaakgakbaaaaaaaaaaa
agabbaaaabaaaaaaagadbaaaaaaaaaaaaaaaaaahdcaabaaaabaaaaaaegaabaaa
acaaaaaajgafbaaaadaaaaaaaaaaaaaibcaabaaaacaaaaaaakaabaaaadaaaaaa
ckiacaaaaaaaaaaaabaaaaaadhaaaaajdcaabaaaaaaaaaaafgafbaaaaaaaaaaa
egaabaaaabaaaaaaigaabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaa
bkbabaaaaaaaaaaaabeaaaaacolkgidodkiacaaaaaaaaaaaabaaaaaaaaaaaaah
ccaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaamnmmemdmefaaaaajpcaabaaa
abaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaoaaaaah
hcaabaaaacaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaabiaaaaaldcaabaaa
adaaaaaaagiacaaaaaaaaaaaacaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaaaaa
aaaaaaaadhaaaaajhcaabaaaaaaaaaaaagaabaaaadaaaaaaegacbaaaacaaaaaa
egacbaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadhaaaaajhccabaaaaaaaaaaafgafbaaaadaaaaaaegacbaaaabaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab
"
}
}
 }
}
}