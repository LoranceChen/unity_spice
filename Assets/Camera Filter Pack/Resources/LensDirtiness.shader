Shader "Hidden/LensDirtiness" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "black" {}
}
SubShader { 
 Pass {
  Name "THRESHOLD"
  ZTest False
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"!!ARBvp1.0
# 6 ALU
PARAM c[5] = { program.local[0],
		state.matrix.mvp };
MOV result.texcoord[0].xy, vertex.texcoord[0];
MOV result.texcoord[1].xy, vertex.texcoord[0];
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
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_TexelSize]
"vs_2_0
; 14 ALU
def c5, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r0.x, c5
slt r0.x, c4.y, r0
max r0.x, -r0, r0
slt r0.x, c5, r0
add r0.y, -r0.x, c5
mul r0.z, v1.y, r0.y
add r0.y, -v1, c5
mad oT0.y, r0.x, r0, r0.z
mov oT1.xy, v1
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
mov oT0.x, v1
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 96
Vector 80 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedobkknpdlkkedhejoahnkfkaipkgihbhnabaaaaaajaacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfagphdgjhe
gjgpgoaafeeffiedepepfceeaaklklklfdeieefcjiabaaaaeaaaabaaggaaaaaa
fjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dbaaaaaibcaabaaaaaaaaaaabkiacaaaaaaaaaaaafaaaaaaabeaaaaaaaaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
dhaaaaajcccabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaa
abaaaaaadgaaaaafbccabaaaabaaaaaaakbabaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 96
Vector 80 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedfpmjjikokkbppflnbongdnopnkimaipaabaaaaaanmadaaaaaeaaaaaa
daaaaaaahiabaaaabiadaaaagmadaaaaebgpgodjeaabaaaaeaabaaaaaaacpopp
aaabaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaafaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
agaaapkaaaaaaaaaaaaaaamaaaaaiadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaabaaaaacaaaaabiaagaaaakaamaaaaadaaaaabia
abaaffkaaaaaaaiaaeaaaaaeaaaaaciaabaaffjaagaaffkaagaakkkaaeaaaaae
aaaaacoaaaaaaaiaaaaaffiaabaaffjaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
aaaaaboaabaaaajaabaaaaacabaaadoaabaaoejappppaaaafdeieefcjiabaaaa
eaaaabaaggaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadbaaaaaibcaabaaaaaaaaaaabkiacaaaaaaaaaaaafaaaaaa
abeaaaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaiadpdhaaaaajcccabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaabkbabaaaabaaaaaadgaaaaafbccabaaaabaaaaaaakbabaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaabaaaaaadoaaaaabejfdeheoemaaaaaa
acaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
ebaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafaepfdejfeejepeo
aafeeffiedepepfceeaaklklepfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadamaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adamaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [_Gain]
Float 1 [_Threshold]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 9 ALU, 1 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.33333334, 0.5, 0 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
ADD R1.x, R0, R0.y;
ADD R1.x, R1, R0.z;
MUL R1.x, R1, c[0];
MUL R1.x, R1, c[2];
ADD R1.x, R1, -c[1];
MUL R1.x, R1, c[2].y;
MAX R1.x, R1, c[2].z;
MUL result.color, R1.x, R0;
END
# 9 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_Gain]
Float 1 [_Threshold]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
; 9 ALU, 1 TEX
dcl_2d s0
def c2, 0.33333334, 0.50000000, 0.00000000, 0
dcl t0.xy
texld r1, t0, s0
add r0.x, r1, r1.y
add r0.x, r0, r1.z
mul r0.x, r0, c0
mul r0.x, r0, c2
add r0.x, r0, -c1
mul r0.x, r0, c2.y
max r0.x, r0, c2.z
mul r0, r0.x, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 96
Float 16 [_Gain]
Float 20 [_Threshold]
BindCB  "$Globals" 0
"ps_4_0
eefiecedkbgdojkoipndkcgnkiganbmbllmjggegabaaaaaacmacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfeabaaaaeaaaaaaaffaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahbcaabaaaabaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaaaaaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaa
akaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
klkkkkdodcaaaaambcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaa
abaaaaaabkiacaiaebaaaaaaaaaaaaaaabaaaaaadiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaadpdeaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaadiaaaaahpccabaaaaaaaaaaaegaobaaaaaaaaaaa
agaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 96
Float 16 [_Gain]
Float 20 [_Threshold]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedjddbpoiblgcplncfbcnngpadhblmeddiabaaaaaadiadaaaaaeaaaaaa
daaaaaaadiabaaaajeacaaaaaeadaaaaebgpgodjaaabaaaaaaabaaaaaaacpppp
mmaaaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaabaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaklkkkkdoaaaaaadp
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaaaaaoelaaaaioekaacaaaaadabaaaiiaaaaaffiaaaaaaaia
acaaaaadabaaabiaaaaakkiaabaappiaafaaaaadabaacbiaabaaaaiaabaaaaka
aeaaaaaeabaacbiaabaaaaiaaaaaaakaaaaaffkbafaaaaadabaacciaabaaaaia
abaaffkaafaaaaadaaaacpiaaaaaoeiaabaaffiafiaaaaaeaaaacpiaabaaaaia
aaaaoeiaabaakkkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcfeabaaaa
eaaaaaaaffaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahbcaabaaa
abaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaahbcaabaaaabaaaaaa
ckaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaklkkkkdodcaaaaambcaabaaaabaaaaaaakaabaaaabaaaaaa
akiacaaaaaaaaaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaabaaaaaadiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpdeaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaahpccabaaaaaaaaaaa
egaobaaaaaaaaaaaagaabaaaabaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadaaaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
 Pass {
  Name "KAWASE"
  ZTest False
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"!!ARBvp1.0
# 6 ALU
PARAM c[5] = { program.local[0],
		state.matrix.mvp };
MOV result.texcoord[0].xy, vertex.texcoord[0];
MOV result.texcoord[1].xy, vertex.texcoord[0];
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
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_TexelSize]
"vs_2_0
; 14 ALU
def c5, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r0.x, c5
slt r0.x, c4.y, r0
max r0.x, -r0, r0
slt r0.x, c5, r0
add r0.y, -r0.x, c5
mul r0.z, v1.y, r0.y
add r0.y, -v1, c5
mad oT0.y, r0.x, r0, r0.z
mov oT1.xy, v1
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
mov oT0.x, v1
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 96
Vector 80 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedobkknpdlkkedhejoahnkfkaipkgihbhnabaaaaaajaacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfagphdgjhe
gjgpgoaafeeffiedepepfceeaaklklklfdeieefcjiabaaaaeaaaabaaggaaaaaa
fjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dbaaaaaibcaabaaaaaaaaaaabkiacaaaaaaaaaaaafaaaaaaabeaaaaaaaaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
dhaaaaajcccabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaa
abaaaaaadgaaaaafbccabaaaabaaaaaaakbabaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 96
Vector 80 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedfpmjjikokkbppflnbongdnopnkimaipaabaaaaaanmadaaaaaeaaaaaa
daaaaaaahiabaaaabiadaaaagmadaaaaebgpgodjeaabaaaaeaabaaaaaaacpopp
aaabaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaafaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
agaaapkaaaaaaaaaaaaaaamaaaaaiadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaabaaaaacaaaaabiaagaaaakaamaaaaadaaaaabia
abaaffkaaaaaaaiaaeaaaaaeaaaaaciaabaaffjaagaaffkaagaakkkaaeaaaaae
aaaaacoaaaaaaaiaaaaaffiaabaaffjaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
aaaaaboaabaaaajaabaaaaacabaaadoaabaaoejappppaaaafdeieefcjiabaaaa
eaaaabaaggaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadbaaaaaibcaabaaaaaaaaaaabkiacaaaaaaaaaaaafaaaaaa
abeaaaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaiadpdhaaaaajcccabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaabkbabaaaabaaaaaadgaaaaafbccabaaaabaaaaaaakbabaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaabaaaaaadoaaaaabejfdeheoemaaaaaa
acaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
ebaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafaepfdejfeejepeo
aafeeffiedepepfceeaaklklepfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadamaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adamaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [_Offset]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 14 ALU, 4 TEX
PARAM c[2] = { program.local[0],
		{ 0.25 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ADD R1.zw, fragment.texcoord[0].xyxy, -c[0].xyxy;
ADD R0.zw, fragment.texcoord[0].xyxy, c[0].xyxy;
MOV R1.x, R0.z;
MOV R1.y, R1.w;
MOV R0.x, R1.z;
MOV R0.y, R0.w;
TEX R3, R1.zwzw, texture[0], 2D;
TEX R2, R1, texture[0], 2D;
TEX R1, R0.zwzw, texture[0], 2D;
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
ADD R0, R0, R2;
ADD R0, R0, R3;
MUL result.color, R0, c[1].x;
END
# 14 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_Offset]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
; 11 ALU, 4 TEX
dcl_2d s0
def c1, 0.25000000, 0, 0, 0
dcl t0.xy
add r2.xy, t0, c0
add r0.xy, t0, -c0
mov r3.y, r2
mov r3.x, r0
mov r1.y, r0
mov r1.x, r2
texld r0, r0, s0
texld r1, r1, s0
texld r2, r2, s0
texld r3, r3, s0
add r2, r3, r2
add r1, r2, r1
add r0, r1, r0
mul r0, r0, c1.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 96
Vector 64 [_Offset]
BindCB  "$Globals" 0
"ps_4_0
eefiecedhcflpifomoiibkbmbonfdmecilehngcoabaaaaaaiaacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckiabaaaaeaaaaaaagkaaaaaa
fjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaaaaaaaaaimcaabaaaaaaaaaaafgbbbaaaabaaaaaa
fgibcaaaaaaaaaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaalgapbaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaajdcaabaaaaaaaaaaaegbabaaa
abaaaaaaegiacaiaebaaaaaaaaaaaaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaa
igaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
adaaaaaahgapbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaah
pcaabaaaabaaaaaaegaobaaaadaaaaaaegaobaaaabaaaaaaaaaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadiaaaaakpccabaaaaaaaaaaa
egaobaaaaaaaaaaaaceaaaaaaaaaiadoaaaaiadoaaaaiadoaaaaiadodoaaaaab
"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 96
Vector 64 [_Offset]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedhgjbmnfbofjaaoflpedhcmmgdmagbafnabaaaaaaaaaeaaaaaeaaaaaa
daaaaaaakmabaaaafmadaaaammadaaaaebgpgodjheabaaaaheabaaaaaaacpppp
eaabaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaaeaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaiadoaaaaaaaa
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaajaaaaiapka
acaaaaadaaaaaciaaaaaaalaaaaaaakbacaaaaadaaaaabiaaaaaaalaaaaaaaka
acaaaaadaaaaaeiaaaaafflaaaaaffkaabaaaaacabaaadiaaaaamjiaabaaaaac
acaaabiaaaaaffiaabaaaaacaaaaaciaaaaakkiaabaaaaacadaaabiaaaaaaaia
acaaaaadadaaaciaaaaafflaaaaaffkbabaaaaacacaaaciaadaaffiaecaaaaad
abaaapiaabaaoeiaaaaioekaecaaaaadaaaaapiaaaaaoeiaaaaioekaecaaaaad
adaaapiaadaaoeiaaaaioekaecaaaaadacaaapiaacaaoeiaaaaioekaacaaaaad
aaaaapiaaaaaoeiaabaaoeiaacaaaaadaaaaapiaadaaoeiaaaaaoeiaacaaaaad
aaaaapiaacaaoeiaaaaaoeiaafaaaaadaaaacpiaaaaaoeiaabaaaakaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefckiabaaaaeaaaaaaagkaaaaaafjaaaaae
egiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaaaaaaaaaimcaabaaaaaaaaaaafgbbbaaaabaaaaaafgibcaaa
aaaaaaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaalgapbaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaajdcaabaaaaaaaaaaaegbabaaaabaaaaaa
egiacaiaebaaaaaaaaaaaaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaigaabaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
hgapbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaadaaaaaaegaobaaaabaaaaaaaaaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaabaaaaaadiaaaaakpccabaaaaaaaaaaaegaobaaa
aaaaaaaaaceaaaaaaaaaiadoaaaaiadoaaaaiadoaaaaiadodoaaaaabejfdeheo
giaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaadaaaaaafdfgfpfagphdgjhegjgpgoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
}
 }
 Pass {
  Name "COMPOSE"
  ZTest False
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Keywords { "_" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"!!ARBvp1.0
# 6 ALU
PARAM c[5] = { program.local[0],
		state.matrix.mvp };
MOV result.texcoord[0].xy, vertex.texcoord[0];
MOV result.texcoord[1].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "_" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_TexelSize]
"vs_2_0
; 14 ALU
def c5, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r0.x, c5
slt r0.x, c4.y, r0
max r0.x, -r0, r0
slt r0.x, c5, r0
add r0.y, -r0.x, c5
mul r0.z, v1.y, r0.y
add r0.y, -v1, c5
mad oT0.y, r0.x, r0, r0.z
mov oT1.xy, v1
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
mov oT0.x, v1
"
}
SubProgram "d3d11 " {
Keywords { "_" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 96
Vector 80 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedobkknpdlkkedhejoahnkfkaipkgihbhnabaaaaaajaacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfagphdgjhe
gjgpgoaafeeffiedepepfceeaaklklklfdeieefcjiabaaaaeaaaabaaggaaaaaa
fjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dbaaaaaibcaabaaaaaaaaaaabkiacaaaaaaaaaaaafaaaaaaabeaaaaaaaaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
dhaaaaajcccabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaa
abaaaaaadgaaaaafbccabaaaabaaaaaaakbabaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "_" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 96
Vector 80 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedfpmjjikokkbppflnbongdnopnkimaipaabaaaaaanmadaaaaaeaaaaaa
daaaaaaahiabaaaabiadaaaagmadaaaaebgpgodjeaabaaaaeaabaaaaaaacpopp
aaabaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaafaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
agaaapkaaaaaaaaaaaaaaamaaaaaiadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaabaaaaacaaaaabiaagaaaakaamaaaaadaaaaabia
abaaffkaaaaaaaiaaeaaaaaeaaaaaciaabaaffjaagaaffkaagaakkkaaeaaaaae
aaaaacoaaaaaaaiaaaaaffiaabaaffjaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
aaaaaboaabaaaajaabaaaaacabaaadoaabaaoejappppaaaafdeieefcjiabaaaa
eaaaabaaggaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadbaaaaaibcaabaaaaaaaaaaabkiacaaaaaaaaaaaafaaaaaa
abeaaaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaiadpdhaaaaajcccabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaabkbabaaaabaaaaaadgaaaaafbccabaaaabaaaaaaakbabaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaabaaaaaadoaaaaabejfdeheoemaaaaaa
acaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
ebaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafaepfdejfeejepeo
aafeeffiedepepfceeaaklklepfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadamaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adamaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "_SCENE_TINTS_BLOOM" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"!!ARBvp1.0
# 6 ALU
PARAM c[5] = { program.local[0],
		state.matrix.mvp };
MOV result.texcoord[0].xy, vertex.texcoord[0];
MOV result.texcoord[1].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "_SCENE_TINTS_BLOOM" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_TexelSize]
"vs_2_0
; 14 ALU
def c5, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r0.x, c5
slt r0.x, c4.y, r0
max r0.x, -r0, r0
slt r0.x, c5, r0
add r0.y, -r0.x, c5
mul r0.z, v1.y, r0.y
add r0.y, -v1, c5
mad oT0.y, r0.x, r0, r0.z
mov oT1.xy, v1
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
mov oT0.x, v1
"
}
SubProgram "d3d11 " {
Keywords { "_SCENE_TINTS_BLOOM" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 96
Vector 80 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedobkknpdlkkedhejoahnkfkaipkgihbhnabaaaaaajaacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfagphdgjhe
gjgpgoaafeeffiedepepfceeaaklklklfdeieefcjiabaaaaeaaaabaaggaaaaaa
fjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dbaaaaaibcaabaaaaaaaaaaabkiacaaaaaaaaaaaafaaaaaaabeaaaaaaaaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
dhaaaaajcccabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaa
abaaaaaadgaaaaafbccabaaaabaaaaaaakbabaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "_SCENE_TINTS_BLOOM" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 96
Vector 80 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedfpmjjikokkbppflnbongdnopnkimaipaabaaaaaanmadaaaaaeaaaaaa
daaaaaaahiabaaaabiadaaaagmadaaaaebgpgodjeaabaaaaeaabaaaaaaacpopp
aaabaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaafaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
agaaapkaaaaaaaaaaaaaaamaaaaaiadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaabaaaaacaaaaabiaagaaaakaamaaaaadaaaaabia
abaaffkaaaaaaaiaaeaaaaaeaaaaaciaabaaffjaagaaffkaagaakkkaaeaaaaae
aaaaacoaaaaaaaiaaaaaffiaabaaffjaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
aaaaaboaabaaaajaabaaaaacabaaadoaabaaoejappppaaaafdeieefcjiabaaaa
eaaaabaaggaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadbaaaaaibcaabaaaaaaaaaaabkiacaaaaaaaaaaaafaaaaaa
abeaaaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaiadpdhaaaaajcccabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaabkbabaaaabaaaaaadgaaaaafbccabaaaabaaaaaaakbabaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaabaaaaaadoaaaaabejfdeheoemaaaaaa
acaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
ebaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafaepfdejfeejepeo
aafeeffiedepepfceeaaklklepfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadamaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adamaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "_" }
Float 0 [_BloomIntensity]
Float 1 [_Dirtiness]
Vector 2 [_BloomColor]
SetTexture 0 [_Bloom] 2D 0
SetTexture 1 [_DirtinessTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 3 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.33333334, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R1.xyz, fragment.texcoord[1], texture[0], 2D;
TEX R0.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R2.xyz, fragment.texcoord[0], texture[1], 2D;
ADD R0.w, R1.x, R1.y;
ADD R0.w, R0, R1.z;
MUL R0.w, R0, c[0].x;
MUL R0.w, R0, c[3].x;
MUL R1.xyz, R0.w, R2;
MAD R0.xyz, R1, c[1].x, R0;
MAD result.color.xyz, R0.w, c[2], R0;
MOV result.color.w, c[3].y;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "_" }
Float 0 [_BloomIntensity]
Float 1 [_Dirtiness]
Vector 2 [_BloomColor]
SetTexture 0 [_Bloom] 2D 0
SetTexture 1 [_DirtinessTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_2_0
; 9 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c3, 0.33333334, 1.00000000, 0, 0
dcl t0.xy
dcl t1.xy
texld r0, t1, s0
texld r2, t1, s2
texld r1, t0, s1
add r0.x, r0, r0.y
add r0.x, r0, r0.z
mul r0.x, r0, c0
mul r0.x, r0, c3
mul r1.xyz, r0.x, r1
mad r1.xyz, r1, c1.x, r2
mov r0.w, c3.y
mad r0.xyz, r0.x, c2, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "_" }
SetTexture 0 [_Bloom] 2D 1
SetTexture 1 [_DirtinessTexture] 2D 2
SetTexture 2 [_MainTex] 2D 0
ConstBuffer "$Globals" 96
Float 28 [_BloomIntensity]
Float 32 [_Dirtiness]
Vector 48 [_BloomColor]
BindCB  "$Globals" 0
"ps_4_0
eefiecedaheaibnbbilliedfgbmdonccmlemhkflabaaaaaaneacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpmabaaaaeaaaaaaahpaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkiacaaaaaaaaaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaklkkkkdoefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaadiaaaaahocaabaaaaaaaaaaaagaabaaaaaaaaaaa
agajbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaa
acaaaaaaaagabaaaaaaaaaaadcaaaaakocaabaaaaaaaaaaafgaobaaaaaaaaaaa
agiacaaaaaaaaaaaacaaaaaaagajbaaaabaaaaaadcaaaaakhccabaaaaaaaaaaa
agaabaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaajgahbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "_" }
SetTexture 0 [_Bloom] 2D 1
SetTexture 1 [_DirtinessTexture] 2D 2
SetTexture 2 [_MainTex] 2D 0
ConstBuffer "$Globals" 96
Float 28 [_BloomIntensity]
Float 32 [_Dirtiness]
Vector 48 [_BloomColor]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedfmofegjgaobcabgdabmjoflbkpobjeihabaaaaaadiaeaaaaaeaaaaaa
daaaaaaajaabaaaajeadaaaaaeaeaaaaebgpgodjfiabaaaafiabaaaaaaacpppp
bmabaaaadmaaaaaaabaadaaaaaaadmaaaaaadmaaadaaceaaaaaadmaaacaaaaaa
aaababaaabacacaaaaaaabaaadaaaaaaaaaaaaaaaaacppppfbaaaaafadaaapka
klkkkkdoaaaaiadpaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaacdlabpaaaaac
aaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
bpaaaaacaaaaaajaacaiapkaecaaaaadaaaaapiaabaaoelaabaioekaecaaaaad
abaacpiaaaaaoelaacaioekaecaaaaadacaaapiaabaaoelaaaaioekaacaaaaad
abaaaiiaaaaaffiaaaaaaaiaacaaaaadabaaaiiaaaaakkiaabaappiaafaaaaad
abaaaiiaabaappiaaaaappkaafaaaaadabaaaiiaabaappiaadaaaakaafaaaaad
aaaaahiaabaaoeiaabaappiaaeaaaaaeaaaaahiaaaaaoeiaabaaaakaacaaoeia
aeaaaaaeaaaachiaabaappiaacaaoekaaaaaoeiaabaaaaacaaaaciiaadaaffka
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcpmabaaaaeaaaaaaahpaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkiacaaaaaaaaaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaklkkkkdoefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaadiaaaaahocaabaaaaaaaaaaaagaabaaaaaaaaaaa
agajbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaa
acaaaaaaaagabaaaaaaaaaaadcaaaaakocaabaaaaaaaaaaafgaobaaaaaaaaaaa
agiacaaaaaaaaaaaacaaaaaaagajbaaaabaaaaaadcaaaaakhccabaaaaaaaaaaa
agaabaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaajgahbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaabejfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "_SCENE_TINTS_BLOOM" }
Float 0 [_BloomIntensity]
Float 1 [_Dirtiness]
Vector 2 [_BloomColor]
SetTexture 0 [_Bloom] 2D 0
SetTexture 1 [_DirtinessTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 8 ALU, 3 TEX
PARAM c[4] = { program.local[0..2],
		{ 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R1.xyz, fragment.texcoord[1], texture[0], 2D;
TEX R0.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R2.xyz, fragment.texcoord[0], texture[1], 2D;
MUL R1.xyz, R1, c[0].x;
MUL R2.xyz, R1, R2;
MAD R0.xyz, R2, c[1].x, R0;
MAD result.color.xyz, R1, c[2], R0;
MOV result.color.w, c[3].x;
END
# 8 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "_SCENE_TINTS_BLOOM" }
Float 0 [_BloomIntensity]
Float 1 [_Dirtiness]
Vector 2 [_BloomColor]
SetTexture 0 [_Bloom] 2D 0
SetTexture 1 [_DirtinessTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_2_0
; 6 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c3, 1.00000000, 0, 0, 0
dcl t0.xy
dcl t1.xy
texld r0, t0, s1
texld r2, t1, s2
texld r1, t1, s0
mul r1.xyz, r1, c0.x
mul r0.xyz, r1, r0
mad r0.xyz, r0, c1.x, r2
mov r0.w, c3.x
mad r0.xyz, r1, c2, r0
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "_SCENE_TINTS_BLOOM" }
SetTexture 0 [_Bloom] 2D 1
SetTexture 1 [_DirtinessTexture] 2D 2
SetTexture 2 [_MainTex] 2D 0
ConstBuffer "$Globals" 96
Float 28 [_BloomIntensity]
Float 32 [_Dirtiness]
Vector 48 [_BloomColor]
BindCB  "$Globals" 0
"ps_4_0
eefiecedgahgnnbhiodfjjhjjmnlhajdgmohmkddabaaaaaaiaacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckiabaaaaeaaaaaaagkaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaapgipcaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaacaaaaaaegacbaaaacaaaaaa
dcaaaaakhccabaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "_SCENE_TINTS_BLOOM" }
SetTexture 0 [_Bloom] 2D 1
SetTexture 1 [_DirtinessTexture] 2D 2
SetTexture 2 [_MainTex] 2D 0
ConstBuffer "$Globals" 96
Float 28 [_BloomIntensity]
Float 32 [_Dirtiness]
Vector 48 [_BloomColor]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedohejfphhmjdjnpfedbjeooejelbhlfjhabaaaaaaleadaaaaaeaaaaaa
daaaaaaagaabaaaabaadaaaaiaadaaaaebgpgodjciabaaaaciabaaaaaaacpppp
omaaaaaadmaaaaaaabaadaaaaaaadmaaaaaadmaaadaaceaaaaaadmaaacaaaaaa
aaababaaabacacaaaaaaabaaadaaaaaaaaaaaaaaaaacppppfbaaaaafadaaapka
aaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaacdlabpaaaaac
aaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
bpaaaaacaaaaaajaacaiapkaecaaaaadaaaacpiaaaaaoelaacaioekaecaaaaad
abaaapiaabaaoelaabaioekaecaaaaadacaaapiaabaaoelaaaaioekaafaaaaad
abaaahiaabaaoeiaaaaappkaafaaaaadaaaaahiaaaaaoeiaabaaoeiaaeaaaaae
aaaaahiaaaaaoeiaabaaaakaacaaoeiaaeaaaaaeaaaachiaabaaoeiaacaaoeka
aaaaoeiaabaaaaacaaaaciiaadaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefckiabaaaaeaaaaaaagkaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaa
aaaaaaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaa
aaaaaaaaacaaaaaaegacbaaaacaaaaaadcaaaaakhccabaaaaaaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaadaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
 Pass {
  ZTest False
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_Offset]
"!!ARBvp1.0
# 11 ALU
PARAM c[7] = { { 2, -2, 3, -3 },
		state.matrix.mvp,
		program.local[5],
		{ 4, -4, 1, -1 } };
TEMP R0;
TEMP R1;
MOV R1, c[6];
MOV R0, c[0];
MAD result.texcoord[1], R1.zzww, c[5].xyxy, vertex.texcoord[0].xyxy;
MAD result.texcoord[2], R0.xxyy, c[5].xyxy, vertex.texcoord[0].xyxy;
MAD result.texcoord[3], R0.zzww, c[5].xyxy, vertex.texcoord[0].xyxy;
MAD result.texcoord[4], R1.xxyy, c[5].xyxy, vertex.texcoord[0].xyxy;
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 11 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_Offset]
"vs_2_0
; 13 ALU
def c5, 1.00000000, -1.00000000, 2.00000000, -2.00000000
def c6, 3.00000000, -3.00000000, 4.00000000, -4.00000000
dcl_position0 v0
dcl_texcoord0 v1
mov r0.xy, c4
mov r0.zw, c4.xyxy
mad oT1, c5.xxyy, r0.xyxy, v1.xyxy
mad oT2, c5.zzww, r0.zwzw, v1.xyxy
mov r0.xy, c4
mov r0.zw, c4.xyxy
mad oT3, c6.xxyy, r0.xyxy, v1.xyxy
mad oT4, c6.zzww, r0.zwzw, v1.xyxy
mov oT0.xy, v1
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 96
Vector 64 [_Offset]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedghgkcegbihmncdbmfacpnlfecoaogcliabaaaaaafeadaaaaadaaaaaa
cmaaaaaaiaaaaaaadiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaakeaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
fdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklfdeieefcbeacaaaa
eaaaabaaifaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
gfaaaaadpccabaaaafaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaabaaaaaa
dcaaaaanpccabaaaacaaaaaaegiecaaaaaaaaaaaaeaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaialpaaaaialpegbebaaaabaaaaaadcaaaaanpccabaaaadaaaaaa
egiecaaaaaaaaaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaamaaaaaaama
egbebaaaabaaaaaadcaaaaanpccabaaaaeaaaaaaegiecaaaaaaaaaaaaeaaaaaa
aceaaaaaaaaaeaeaaaaaeaeaaaaaeamaaaaaeamaegbebaaaabaaaaaadcaaaaan
pccabaaaafaaaaaaegiecaaaaaaaaaaaaeaaaaaaaceaaaaaaaaaiaeaaaaaiaea
aaaaiamaaaaaiamaegbebaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 96
Vector 64 [_Offset]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefieceddeppgopgnnomnpgepplndhmfpnhpaeilabaaaaaameaeaaaaaeaaaaaa
daaaaaaajmabaaaaliadaaaaamaeaaaaebgpgodjgeabaaaageabaaaaaaacpopp
ceabaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaaeaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
agaaapkaaaaaiadpaaaaialpaaaaaaeaaaaaaamafbaaaaafahaaapkaaaaaeaea
aaaaeamaaaaaiaeaaaaaiamabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabia
abaaapjaabaaaaacaaaaadiaabaaoekaaeaaaaaeabaaapoaaaaaeeiaagaafaka
abaaeejaaeaaaaaeacaaapoaaaaaeeiaagaapkkaabaaeejaaeaaaaaeadaaapoa
aaaaeeiaahaafakaabaaeejaaeaaaaaeaeaaapoaaaaaeeiaahaapkkaabaaeeja
afaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapiaacaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiaabaaaaacaaaaadoaabaaoejappppaaaafdeieefc
beacaaaaeaaaabaaifaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaa
aeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaa
abaaaaaadcaaaaanpccabaaaacaaaaaaegiecaaaaaaaaaaaaeaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaialpaaaaialpegbebaaaabaaaaaadcaaaaanpccabaaa
adaaaaaaegiecaaaaaaaaaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaama
aaaaaamaegbebaaaabaaaaaadcaaaaanpccabaaaaeaaaaaaegiecaaaaaaaaaaa
aeaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeamaaaaaeamaegbebaaaabaaaaaa
dcaaaaanpccabaaaafaaaaaaegiecaaaaaaaaaaaaeaaaaaaaceaaaaaaaaaiaea
aaaaiaeaaaaaiamaaaaaiamaegbebaaaabaaaaaadoaaaaabejfdeheoemaaaaaa
acaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
ebaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafaepfdejfeejepeo
aafeeffiedepepfceeaaklklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 26 ALU, 9 TEX
PARAM c[2] = { { 0.22499999, 0.15000001, 0.11, 0.075000003 },
		{ 0.052499998 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEMP R8;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2, fragment.texcoord[1].zwzw, texture[0], 2D;
TEX R1, fragment.texcoord[1], texture[0], 2D;
TEX R8, fragment.texcoord[4].zwzw, texture[0], 2D;
TEX R7, fragment.texcoord[4], texture[0], 2D;
TEX R6, fragment.texcoord[3].zwzw, texture[0], 2D;
TEX R5, fragment.texcoord[3], texture[0], 2D;
TEX R4, fragment.texcoord[2].zwzw, texture[0], 2D;
TEX R3, fragment.texcoord[2], texture[0], 2D;
MUL R2, R2, c[0].y;
MUL R1, R1, c[0].y;
MUL R0, R0, c[0].x;
ADD R0, R0, R1;
ADD R0, R0, R2;
MUL R1, R3, c[0].z;
ADD R0, R0, R1;
MUL R2, R4, c[0].z;
ADD R0, R0, R2;
MUL R1, R5, c[0].w;
ADD R0, R0, R1;
MUL R2, R6, c[0].w;
ADD R0, R0, R2;
MUL R1, R7, c[1].x;
MUL R2, R8, c[1].x;
ADD R0, R0, R1;
ADD result.color, R0, R2;
END
# 26 instructions, 9 R-regs
"
}
SubProgram "d3d9 " {
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
; 29 ALU, 9 TEX
dcl_2d s0
def c0, 0.22499999, 0.15000001, 0.11000000, 0.07500000
def c1, 0.05250000, 0, 0, 0
dcl t0.xy
dcl t1
dcl t2
dcl t3
dcl t4
texld r3, t3, s0
texld r5, t2, s0
texld r8, t0, s0
texld r7, t1, s0
mov r0.y, t1.w
mov r0.x, t1.z
mov r6.xy, r0
mov r0.y, t2.w
mov r0.x, t2.z
mov r4.xy, r0
mov r1.y, t3.w
mov r1.x, t3.z
mov r2.xy, r1
mov r0.y, t4.w
mov r0.x, t4.z
mul r7, r7, c0.y
mul r8, r8, c0.x
add_pp r7, r8, r7
mul r5, r5, c0.z
mul r3, r3, c0.w
texld r0, r0, s0
texld r1, t4, s0
texld r2, r2, s0
texld r4, r4, s0
texld r6, r6, s0
mul r6, r6, c0.y
add_pp r6, r7, r6
mul r4, r4, c0.z
add_pp r5, r6, r5
add_pp r4, r5, r4
mul r2, r2, c0.w
add_pp r3, r4, r3
add_pp r2, r3, r2
mul r1, r1, c1.x
mul r0, r0, c1.x
add_pp r1, r2, r1
add_pp r0, r1, r0
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedecmjibdhflelpoecehbijkkkbkkaigeeabaaaaaaieaeaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgeadaaaa
eaaaaaaanjaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaad
pcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaakpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaajkjjbjdojkjjbjdojkjjbjdojkjjbjdo
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaaggggggdo
ggggggdoggggggdoggggggdoegaobaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
ogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaabaaaaaaaceaaaaajkjjbjdojkjjbjdojkjjbjdojkjjbjdo
egaobaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaabaaaaaa
aceaaaaakoehobdnkoehobdnkoehobdnkoehobdnegaobaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaampcaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaakoehobdnkoehobdn
koehobdnkoehobdnegaobaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
aeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaa
egaobaaaabaaaaaaaceaaaaajkjjjjdnjkjjjjdnjkjjjjdnjkjjjjdnegaobaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaaeaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaa
jkjjjjdnjkjjjjdnjkjjjjdnjkjjjjdnegaobaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
pcaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaadnakfhdndnakfhdndnakfhdn
dnakfhdnegaobaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaafaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampccabaaaaaaaaaaaegaobaaa
abaaaaaaaceaaaaadnakfhdndnakfhdndnakfhdndnakfhdnegaobaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedhdfdagfdfgfgakfjfigdmopfpgbgmpgoabaaaaaaoeagaaaaaeaaaaaa
daaaaaaaimacaaaapiafaaaalaagaaaaebgpgodjfeacaaaafeacaaaaaaacpppp
cmacaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkadnakfhdnaaaaaaaaaaaaaaaaaaaaaaaafbaaaaaf
abaaapkajkjjbjdoggggggdokoehobdnjkjjjjdnbpaaaaacaaaaaaiaaaaacdla
bpaaaaacaaaaaaiaabaacplabpaaaaacaaaaaaiaacaacplabpaaaaacaaaaaaia
adaacplabpaaaaacaaaaaaiaaeaacplabpaaaaacaaaaaajaaaaiapkaabaaaaac
aaaacbiaabaakklaabaaaaacaaaacciaabaapplaabaaaaacabaacbiaacaakkla
abaaaaacabaacciaacaapplaabaaaaacacaacbiaadaakklaabaaaaacacaaccia
adaapplaabaaaaacadaacbiaaeaakklaabaaaaacadaacciaaeaapplaecaaaaad
aeaaapiaabaaoelaaaaioekaecaaaaadafaaapiaaaaaoelaaaaioekaecaaaaad
aaaaapiaaaaaoeiaaaaioekaecaaaaadagaaapiaacaaoelaaaaioekaecaaaaad
abaaapiaabaaoeiaaaaioekaecaaaaadahaaapiaadaaoelaaaaioekaecaaaaad
acaaapiaacaaoeiaaaaioekaecaaaaadaiaaapiaaeaaoelaaaaioekaecaaaaad
adaaapiaadaaoeiaaaaioekaafaaaaadaeaaapiaaeaaoeiaabaaaakaaeaaaaae
aeaacpiaafaaoeiaabaaffkaaeaaoeiaaeaaaaaeaaaacpiaaaaaoeiaabaaaaka
aeaaoeiaaeaaaaaeaaaacpiaagaaoeiaabaakkkaaaaaoeiaaeaaaaaeaaaacpia
abaaoeiaabaakkkaaaaaoeiaaeaaaaaeaaaacpiaahaaoeiaabaappkaaaaaoeia
aeaaaaaeaaaacpiaacaaoeiaabaappkaaaaaoeiaaeaaaaaeaaaacpiaaiaaoeia
aaaaaakaaaaaoeiaaeaaaaaeaaaacpiaadaaoeiaaaaaaakaaaaaoeiaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefcgeadaaaaeaaaaaaanjaaaaaafkaaaaad
aagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaad
pcbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadiaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
aceaaaaajkjjbjdojkjjbjdojkjjbjdojkjjbjdoefaaaaajpcaabaaaabaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaabaaaaaaaceaaaaaggggggdoggggggdoggggggdoggggggdo
egaobaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaabaaaaaa
aceaaaaajkjjbjdojkjjbjdojkjjbjdojkjjbjdoegaobaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaampcaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaakoehobdnkoehobdn
koehobdnkoehobdnegaobaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaa
egaobaaaabaaaaaaaceaaaaakoehobdnkoehobdnkoehobdnkoehobdnegaobaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaa
jkjjjjdnjkjjjjdnjkjjjjdnjkjjjjdnegaobaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
pcaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaajkjjjjdnjkjjjjdnjkjjjjdn
jkjjjjdnegaobaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaafaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
abaaaaaaaceaaaaadnakfhdndnakfhdndnakfhdndnakfhdnegaobaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaogbkbaaaafaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaampccabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaadnakfhdn
dnakfhdndnakfhdndnakfhdnegaobaaaaaaaaaaadoaaaaabejfdeheolaaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
keaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapapaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaa
keaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaafdfgfpfagphdgjhe
gjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
}
 }
}
Fallback Off
}