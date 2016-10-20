Shader "CameraFilterPack/TV_ARCADE_2" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _TimeX ("Time", Range(0,1)) = 1
 _Distortion ("_Distortion", Range(0,1)) = 0.3
 _ScreenResolution ("_ScreenResolution", Vector) = (0,0,0,0)
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
Vector 4 [_ScreenResolution]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 104 ALU, 2 TEX
PARAM c[15] = { program.local[0..4],
		{ 0.001, 0.5, 2.2, 0 },
		{ 0.2, 1, 0.25, 0.92000002 },
		{ 0.039999999, 0.050000001, 0.1, 10 },
		{ -4, 0.02, 0.30000001, 21 },
		{ 0.69999999, 29, 0.33000001, 31 },
		{ 0.0017, 0.025, -0.02, 0.75 },
		{ 0.079999998, 0.60000002, 0.40000001, 16 },
		{ 3.5, 1.5, 0.34999999, 1.7 },
		{ 110, 0.0099999998, 2.6600001, 2.9400001 },
		{ 0.64999998 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ADD R0.xy, fragment.texcoord[0], -c[5].y;
MUL R0.xy, R0, c[5].z;
ABS R0.z, R0.y;
MUL R0.w, R0.z, c[6].x;
MUL R0.z, R0.w, R0;
MAD R0.z, R0, c[6].x, c[6].y;
MUL R0.x, R0, R0.z;
ABS R0.z, R0.x;
MUL R0.w, R0.z, c[6].z;
MUL R0.z, R0.w, R0;
MAD R0.z, R0, c[6], c[6].y;
MUL R0.y, R0, R0.z;
MOV R0.z, c[2].x;
MAD R0.xy, R0, c[5].y, c[5].y;
MUL R0.xy, R0, c[6].w;
MUL R0.z, R0, -c[0].x;
ADD R2.xy, R0, c[7].x;
FRC R0.z, R0;
MAD R0.x, R2.y, c[1], -R0.z;
ADD R0.x, R0, -c[7].y;
MIN_SAT R0.x, R0, c[7].z;
MUL R0.x, R0, c[7].w;
ADD R0.y, R0.x, -c[5];
MUL R0.y, R0, R0;
MUL R0.y, R0, c[8].x;
MUL R0.x, R0, c[7].w;
MOV R1.xy, c[9].xzzw;
ADD R0.y, R0, c[6];
SIN R0.x, R0.x;
MUL R0.x, R0, R0.y;
MUL R0.w, R0.x, c[8].y;
MOV R0.x, c[5].w;
ADD R2.zw, R2.xyxy, R0.xywx;
MUL R0.y, R2, c[9].w;
MAD R0.y, R1, c[0].x, R0;
ADD R0.x, R0.y, c[8].z;
MUL R0.y, R2, c[9];
MAD R1.x, R1, c[0], R0.y;
SIN R0.x, R0.x;
MUL R0.z, R2.y, c[8].w;
MOV R0.y, c[8].z;
MAD R0.y, R0, c[0].x, R0.z;
SIN R0.z, R1.x;
SIN R0.y, R0.y;
MUL R0.y, R0, R0.z;
MUL R1.x, R0.y, R0;
MAD R0.x, R1, c[10], R2;
ADD R1.zw, R2, c[5].x;
MAD R1.x, R1, c[10], c[10].y;
MOV R1.y, c[10].z;
MAD R3.xy, R1, c[10].w, R1.zwzw;
ADD R0.y, R2, c[5].x;
ADD R0.x, R0, c[5];
TEX R0.xyz, R0, texture[0], 2D;
ADD R1.xyz, R0, c[7].y;
TEX R0.xyz, R3, texture[0], 2D;
MAD R0.y, R0, c[7], R1;
MAD R0.xz, R0, c[11].x, R1;
MUL R1.xyz, R0, R0;
MUL R1.xyz, R1, c[11].z;
MAD_SAT R0.xyz, R0, c[11].y, R1;
ADD R1.z, -R2.w, c[6].y;
ADD R1.y, -R2.z, c[6];
MUL R1.x, R2.z, R2.w;
MUL R1.x, R1, R1.y;
MUL R1.x, R1, R1.z;
MUL R1.y, R2.w, c[4];
MUL R1.z, R1.y, c[12].y;
MOV R1.y, c[12].x;
MAD R1.z, R1.y, c[0].x, R1;
MUL R1.x, R1, c[11].w;
POW R1.y, R1.x, c[8].z;
MUL R0.xyz, R0, R1.y;
SIN R1.x, R1.z;
MAD_SAT R1.x, R1, c[12].z, c[12].z;
MOV R1.y, c[13].x;
POW R1.x, R1.x, c[12].w;
MUL R1.y, R1, c[0].x;
SIN R1.y, R1.y;
MUL R1.x, R1, c[3];
MUL R1.z, R1.y, c[13].y;
MUL R1.x, R1, c[9];
ADD R1.y, R1.x, c[11].z;
MUL R0.xyz, R0, R1.y;
ADD R1.x, R1.z, c[6].y;
MUL R0.xyz, R0, R1.x;
MUL R1.x, fragment.texcoord[0], c[4];
SLT R1.y, c[6], R2.z;
SLT R0.w, R2.x, -R0;
ADD_SAT R0.w, R0, R1.y;
ABS R1.z, R1.x;
MUL R0.xyz, R0, c[13].zwzw;
FRC R1.y, R1.z;
CMP R0.xyz, -R0.w, c[5].w, R0;
CMP R0.w, R1.x, -R1.y, R1.y;
ADD_SAT R1.y, R0.w, -c[6];
SLT R1.x, c[6].y, R2.w;
SLT R0.w, R2.y, -c[5];
ADD_SAT R0.w, R0, R1.x;
MUL R1.y, -R1, c[14].x;
ADD R1.x, R1.y, c[6].y;
CMP R0.xyz, -R0.w, c[5].w, R0;
MUL result.color.xyz, R0, R1.x;
MOV result.color.w, c[6].y;
END
# 104 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_TimeX]
Float 1 [_Value]
Float 2 [_Value2]
Float 3 [_Value3]
Vector 4 [_ScreenResolution]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
; 164 ALU, 2 TEX
dcl_2d s0
def c5, -0.50000000, 2.20000005, 0.20000000, 1.00000000
def c6, 0.25000000, 1.00000000, 0.50000000, -0.05000000
def c7, 0.92000002, 0.04000000, 0.10000000, 10.00000000
def c8, 1.59154904, 0.50000000, 6.28318501, -3.14159298
def c9, -4.00000000, 1.00000000, 0.02000000, 0.00000000
def c10, 21.00000000, 0.30000001, 0.15915491, 0.50000000
def c11, 29.00000000, 0.69999999, 31.00000000, 0.33000001
def c12, 0.00170000, 0.02500000, -0.02000000, 0.00100000
def c13, 0.75000000, 0.05000000, 0.08000000, 0.40000001
def c14, 0.60000002, 16.00000000, 1.50000000, 3.50000000
def c15, 0.34999999, 1.70000005, 0.69999999, 0.40000001
def c16, 17.50704002, 0.50000000, 0.01000000, 1.00000000
def c17, 2.66000009, 2.94000006, -1.00000000, 0
def c18, 0.64999998, 1.00000000, 0, 0
dcl_texcoord0 v0.xy
add r0.xy, v0, c5.x
mul r0.xy, r0, c5.y
abs r0.z, r0.y
mul r0.w, r0.z, c5.z
mul r0.z, r0.w, r0
mad r0.z, r0, c5, c5.w
mul r0.x, r0, r0.z
abs r0.z, r0.x
mul r0.w, r0.z, c6.x
mul r0.z, r0.w, r0
mad r0.z, r0, c6.x, c6.y
mul r0.y, r0, r0.z
mad r0.xy, r0, c6.z, c6.z
mov r0.w, c0.x
mul r0.z, c2.x, -r0.w
mad r2.zw, r0.xyxy, c7.x, c7.y
frc r0.z, r0
mad r0.x, r2.w, c1, -r0.z
add r0.x, r0, c6.w
min_sat r0.y, r0.x, c7.z
mov r0.x, c0
mul r0.z, r2.w, c11
mad r0.z, c11.w, r0.x, r0
mul r0.x, r0.y, c7.w
mad r0.y, r0.x, c8.x, c8
add r0.z, r0, c10.y
frc r0.y, r0
add r0.x, r0, c5
mad r1.z, r0, c10, c10.w
mad r1.x, r0.y, c8.z, c8.w
mul r1.y, r0.x, r0.x
sincos r0.xy, r1.x
mad r0.x, r1.y, c9, c9.y
mul r0.x, r0.y, r0
frc r0.y, r1.z
mad r0.z, r0.y, c8, c8.w
sincos r3.xy, r0.z
mul r0.x, r0, c9.z
mov r0.y, c9.w
add r2.xy, r2.zwzw, r0
mul r0.y, r2.w, c11.x
mov r0.x, c0
mad r0.z, c11.y, r0.x, r0.y
mul r0.y, r2.w, c10.x
mov r0.x, c0
mad r0.x, c10.y, r0, r0.y
mad r0.y, r0.z, c10.z, c10.w
frc r0.y, r0
mad r0.x, r0, c10.z, c10.w
frc r0.x, r0
mad r1.x, r0.y, c8.z, c8.w
mad r3.x, r0, c8.z, c8.w
sincos r0.xy, r1.x
sincos r1.xy, r3.x
mul r0.x, r1.y, r0.y
mul r0.z, r0.x, r3.y
mad r0.w, r0.z, c12.x, r2.z
add r1.x, r0.w, c12.w
add r1.y, r2.w, c12.w
texld r1.xyz, r1, s0
add r1.xyz, r1, c13.y
mad r0.z, r0, c12.x, c12.y
mov r0.w, c12.z
add r0.xy, r2, c12.w
mad r0.xy, r0.zwzw, c13.x, r0
texld r0.xyz, r0, s0
mad r0.xz, r0, c13.z, r1
mad r0.y, r0, c13, r1
mul r1.xyz, r0, r0
mul r1.xyz, r1, c13.w
mad_sat r1.xyz, r0, c14.x, r1
mul r0.z, r2.y, c4.y
add r0.y, -r2.x, c5.w
mul r0.x, r2, r2.y
mul r0.x, r0, r0.y
add r0.y, -r2, c5.w
mul r0.y, r0.x, r0
mul r1.w, r0.y, c14.y
mul r0.z, r0, c14
mov r0.x, c0
mad r0.x, c14.w, r0, r0.z
mad r2.z, r0.x, c10, c10.w
pow r0, r1.w, c10.y
frc r0.y, r2.z
mov r1.w, r0.x
mad r2.z, r0.y, c8, c8.w
sincos r0.xy, r2.z
mul r1.xyz, r1, r1.w
mov r0.x, c0
mad_sat r1.w, r0.y, c15.x, c15.x
mad r2.z, r0.x, c16.x, c16.y
pow r0, r1.w, c15.y
frc r0.y, r2.z
mov r1.w, r0.x
mad r2.z, r0.y, c8, c8.w
sincos r0.xy, r2.z
mul r0.x, r1.w, c3
mad r0.w, r0.y, c16.z, c16
mad r0.x, r0, c15.z, c15.w
mul r0.xyz, r1, r0.x
mul r0.xyz, r0, r0.w
add r0.w, -r2.x, c5
cmp r1.x, r0.w, c9.w, c9.y
cmp r0.w, r2.x, c9, c9.y
add_pp_sat r0.w, r0, r1.x
mul r1.y, v0.x, c4.x
abs r1.x, r1.y
frc r1.z, r1.x
mul r0.xyz, r0, c17.xyxw
cmp r0.xyz, -r0.w, r0, c9.w
add r1.x, -r2.y, c5.w
cmp r1.y, r1, r1.z, -r1.z
cmp r1.x, r1, c9.w, c9.y
cmp r0.w, r2.y, c9, c9.y
add_pp_sat r0.w, r0, r1.x
add_sat r1.y, r1, c17.z
mad r1.x, -r1.y, c18, c18.y
cmp r0.xyz, -r0.w, r0, c9.w
mul oC0.xyz, r0, r1.x
mov_pp oC0.w, c5
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Float 16 [_TimeX]
Float 20 [_Value]
Float 24 [_Value2]
Float 28 [_Value3]
Vector 48 [_ScreenResolution]
BindCB  "$Globals" 0
"ps_4_0
eefiecedaeloclfhnnpajjpgoadnojoojifnaagdabaaaaaafmalaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaadadaaaafjaaaaaaaaaaaaaaabaaaaaa
adaaaaaaabaaaaaaapaaaaaagfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafeeffiedepepfceeaafdfgfpfaepfdejfeejepeoaaedepemepfcaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefciaakaaaaeaaaaaaa
kaacaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaaaaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaadiaaaaakbcaabaaaaaaaaaaackiacaaa
aaaaaaaaabaaaaaaakiacaiaebaaaaaaaaaaaaaaabaaaaaabkaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaaaaaaaakgcaabaaaaaaaaaaaagbbbaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaalpaaaaaalpaaaaaaaadiaaaaakgcaabaaaaaaaaaaa
fgagbaaaaaaaaaaaaceaaaaaaaaaaaaamnmmameamnmmameaaaaaaaaadiaaaaai
icaabaaaaaaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaamnmmemdodcaaaaaj
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaaakaabaiaibaaaaaaabaaaaaaabeaaaaaaaaaiadodcaaaaaj
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahccaabaaaabaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaap
gcaabaaaaaaaaaaaagabbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadp
aaaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadpaaaaaaaadcaaaaapocaabaaa
abaaaaaafgakbaaaaaaaaaaaaceaaaaaaaaaaaaabpifgldpbpifgldpbpifgldp
aceaaaaaaaaaaaaaaknhcddnaknhcddnjnopchdndcaaaaalbcaabaaaaaaaaaaa
ckaabaaaabaaaaaabkiacaaaaaaaaaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaa
aaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaamnmmemlndeaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaddaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaamnmmmmdndcaaaaajicaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaacaebabeaaaaaaaaaaalpdiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaamiecenaaaaagbcaabaaaaaaaaaaa
aanaaaaaakaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiamaabeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaaaaaaaaaabeaaaaa
aknhkddmdiaaaaahccaabaaaadaaaaaackaabaaaaaaaaaaaabeaaaaabpifgldp
dcaaaaajecaabaaaadaaaaaabkaabaaaaaaaaaaaabeaaaaabpifgldpabeaaaaa
aknhcddndcaaaaajccaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaabpifgldp
abeaaaaaipmchflmdgaaaaafccaabaaaacaaaaaaabeaaaaaaknhcddnaaaaaaah
mcaabaaaaaaaaaaaagaebaaaacaaaaaakgagbaaaadaaaaaadiaaaaakdcaabaaa
acaaaaaakgakbaaaabaaaaaaaceaaaaaaaaakiebaaaaoiebaaaaaaaaaaaaaaaa
dcaaaaandcaabaaaacaaaaaaagiacaaaaaaaaaaaabaaaaaaaceaaaaajkjjjjdo
dddddddpaaaaaaaaaaaaaaaaegaabaaaacaaaaaaenaaaaagdcaabaaaacaaaaaa
aanaaaaaegaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaabkaabaaaacaaaaaa
akaabaaaacaaaaaadcaaaaakccaabaaaacaaaaaaakiacaaaaaaaaaaaabaaaaaa
abeaaaaamdpfkidoabeaaaaajkjjjjdodcaaaaajecaabaaaabaaaaaackaabaaa
abaaaaaaabeaaaaaaaaapiebbkaabaaaacaaaaaaenaaaaagecaabaaaabaaaaaa
aanaaaaackaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaa
akaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaackaabaaaabaaaaaaabeaaaaa
ijncnodkabeaaaaamnmmmmdmdcaaaaajccaabaaaabaaaaaackaabaaaabaaaaaa
abeaaaaaijncnodkbkaabaaaabaaaaaaaaaaaaahbcaabaaaabaaaaaabkaabaaa
abaaaaaaabeaaaaagpbciddkefaaaaajpcaabaaaabaaaaaamgaabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaakhcaabaaaabaaaaaaegacbaaa
abaaaaaaaceaaaaamnmmemdnmnmmemdnmnmmemdnaaaaaaaadcaaaaajbcaabaaa
aaaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaeadpckaabaaaaaaaaaaaaaaaaaak
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaagpbciddkjnopchdnaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaaegacbaaaacaaaaaaaceaaaaa
aknhkddnmnmmemdnaknhkddnaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaadiaaaaakhcaabaaaacaaaaaa
egacbaaaacaaaaaaaceaaaaamnmmmmdomnmmmmdomnmmmmdoaaaaaaaadccaaaam
hcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdpjkjjbjdp
aaaaaaaaegacbaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaiaebaaaaaaaldcaabaaaacaaaaaaogakbaiaebaaaaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaaacaaaaaa
akaabaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaajkjjjjdobjaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaa
hbdnckeapgcidmeahbdnckeaaaaaaaaadiaaaaaibcaabaaaaaaaaaaadkaabaaa
aaaaaaaabkiacaaaaaaaaaaaadaaaaaadiaaaaaiccaabaaaaaaaaaaaakiacaaa
aaaaaaaaabaaaaaaabeaaaaaaaaagaeadcaaaaajbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaamadpbkaabaaaaaaaaaaaenaaaaagbcaabaaaaaaaaaaa
aanaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaddddlddoabeaaaaaddddlddocpaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaajkjjnjdp
bjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaadkiacaaaaaaaaaaaabaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaadddddddpabeaaaaamnmmmmdodiaaaaahhcaabaaa
abaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
akiacaaaaaaaaaaaabaaaaaaabeaaaaaaaaanmecenaaaaagbcaabaaaaaaaaaaa
aanaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaknhcddmabeaaaaaaaaaiadpdiaaaaahhcaabaaaabaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaadbaaaaakdcaabaaaaaaaaaaaogakbaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadbaaaaakmcaabaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaiadpkgaobaaaaaaaaaaadmaaaaah
dcaabaaaaaaaaaaaogakbaaaaaaaaaaaegaabaaaaaaaaaaadmaaaaahbcaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadhaaaaamhccabaaaaaaaaaaa
agaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
}
 }
}
}