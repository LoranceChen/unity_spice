Shader "CameraFilterPack/FX_Glitch2" {
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
#ifndef SHADER_API_OPENGL
    #define SHADER_API_OPENGL 1
#endif
#ifndef SHADER_API_DESKTOP
    #define SHADER_API_DESKTOP 1
#endif

#line 151
struct v2f_vertex_lit {
    vec2 uv;
    vec4 diff;
    vec4 spec;
};
#line 187
struct v2f_img {
    vec4 pos;
    vec2 uv;
};
#line 181
struct appdata_img {
    vec4 vertex;
    vec2 texcoord;
};
#line 325
struct v2f {
    vec2 texcoord;
    vec4 vertex;
    vec4 color;
};
#line 318
struct appdata_t {
    vec4 vertex;
    vec4 color;
    vec2 texcoord;
};
uniform vec4 _Time;
uniform vec4 _SinTime;
#line 3
uniform vec4 _CosTime;
uniform vec4 unity_DeltaTime;
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
#line 7
uniform vec4 _ScreenParams;
uniform vec4 _ZBufferParams;
uniform vec4 unity_CameraWorldClipPlanes[6];
uniform vec4 _WorldSpaceLightPos0;
#line 11
uniform vec4 _LightPositionRange;
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
#line 15
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_LightColor[8];
uniform vec4 unity_LightPosition[8];
uniform vec4 unity_LightAtten[8];
#line 19
uniform vec4 unity_SpotDirection[8];
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
#line 23
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;
#line 27
uniform vec3 unity_LightColor0;
uniform vec3 unity_LightColor1;
uniform vec3 unity_LightColor2;
uniform vec3 unity_LightColor3;
uniform vec4 unity_ShadowSplitSpheres[4];
uniform vec4 unity_ShadowSplitSqRadii;
uniform vec4 unity_LightShadowBias;
#line 31
uniform vec4 _LightSplitsNear;
uniform vec4 _LightSplitsFar;
uniform mat4 unity_World2Shadow[4];
uniform vec4 _LightShadowData;
#line 35
uniform vec4 unity_ShadowFadeCenterAndType;



#line 39
uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_Scale;
uniform mat4 glstate_matrix_transpose_modelview0;
#line 43




#line 47


uniform mat4 unity_MatrixV;
uniform mat4 unity_MatrixVP;
#line 51
uniform vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 315
uniform sampler2D _MainTex;
uniform float _TimeX;
uniform vec4 _ScreenResolution;
#line 332
#line 340
#line 344
#line 352
#line 364
#line 340
float hash( in float n ) {
    return fract((sin(n) * 43812.2));
}
#line 352
float noise( in vec3 p ) {
    vec3 pi = floor(p);
    vec3 pf = fract(p);
    #line 356
    float n = ((pi.x + (59.0 * pi.y)) + (256.0 * pi.z));
    pf.x = ((pf.x * pf.x) * (3.0 - (2.0 * pf.x)));
    pf.y = ((pf.y * pf.y) * (3.0 - (2.0 * pf.y)));
    pf.z = sin(pf.z);
    #line 360
    float v1 = mix( mix( hash( n), hash( (n + 1.0)), pf.x), mix( hash( (n + 59.0)), hash( ((n + 1.0) + 59.0)), pf.x), pf.y);
    float v2 = mix( mix( hash( (n + 256.0)), hash( ((n + 1.0) + 256.0)), pf.x), mix( hash( ((n + 59.0) + 256.0)), hash( (((n + 1.0) + 59.0) + 256.0)), pf.x), pf.y);
    return mix( v1, v2, pf.z);
}
#line 364
vec4 frag( in v2f i ) {
    vec2 uv = i.texcoord.xy;
    uv -= 0.5;
    #line 368
    float _TimeX = (_TimeX_1 / 30.0);
    _TimeX = (0.5 + (0.5 * sin((_TimeX * 6.238))));
    _TimeX = texture2D( _MainTex, vec2( 0.5, 0.5)).x;
    if ((_TimeX < 0.2)){
        uv *= 1.0;
    }
    else{
        if ((_TimeX < 0.4)){
            #line 374
            uv.x += 100.55;
            uv *= 5e-05;
        }
        else{
            if ((_TimeX < 0.6)){
                #line 379
                uv *= 0.00045;
            }
            else{
                if ((_TimeX < 0.8)){
                    #line 383
                    uv *= 500000.0;
                }
                else{
                    if ((_TimeX < 1.0)){
                        #line 387
                        uv *= 4.5e-05;
                    }
                }
            }
        }
    }
    float fft = texture2D( _MainTex, vec2( uv.x, 0.25)).x;
    float ftf = texture2D( _MainTex, vec2( uv.x, 0.15)).x;
    #line 391
    float fty = texture2D( _MainTex, vec2( uv.x, 0.35)).x;
    uv *= (200.0 * sin((log(fft) * 10.0)));
    if ((sin(fty) < 0.5)){
        uv.x += (sin(fty) * sin((cos(_TimeX) + (uv.y * 40005.0))));
    }
    uv *= sin((_TimeX * 179.0));
    #line 395
    vec3 p;
    p.x = uv.x;
    p.y = uv.y;
    p.z = sin(((0.0 * _TimeX) * ftf));
    #line 399
    float no = noise( p);
    vec3 col = vec3( hash( ((no * 6.238) * cos(_TimeX))), hash( ((no * 6.2384) + (0.4 * cos((_TimeX * 2.25))))), hash( ((no * 6.2384) + (0.8 * cos((_TimeX * 0.8468))))));
    float b = dot( uv, uv);
    b *= 10000.0;
    #line 403
    b = (b * b);
    col.xyz *= texture2D( _MainTex, i.texcoord.xy).xyz;
    return vec4( col, 1.0);
}
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
void main() {
    vec4 xl_retval;
    v2f xlt_i;
    xlt_i.texcoord = vec2(xlv_TEXCOORD0);
    xlt_i.vertex = vec4(0.0);
    xlt_i.color = vec4(xlv_COLOR);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}
/* NOTE: GLSL optimization failed
0:369(27): error: `_TimeX_1' undeclared
0:369(33): error: Operands to arithmetic operators must be numeric
*/

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
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
; 319 ALU, 4 TEX
dcl_2d s0
def c0, 0.50000000, -0.20000000, 0.00000000, 1.00000000
def c1, -0.40000001, -0.60000002, -0.80000001, -1.00000000
def c2, -0.50000000, 100.55000305, 0.00005000, 0.00045000
def c3, 500000.00000000, 0.00004500, 0.34999999, 0.25000000
def c4, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c5, 1.10317779, 0.50000000, 200.00000000, 40005.00000000
def c6, 28.48872757, 0.50000000, -0.00000048, 59.00000000
def c7, 2.00000000, 3.00000000, 256.00000000, 316.00000000
def c8, 43812.17578125, 315.00000000, 257.00000000, 60.00000000
def c9, 0.99280828, 0.50000000, 0.35809854, 0.40000001
def c10, 6.23839998, 0.13477238, 0.50000000, 0.80000001
dcl_texcoord0 v0.xy
texld r0.x, c0.x, s0
add r2.xy, v0, c2.x
add r0.z, r0.x, c1.x
add r0.y, r0.x, c0
add r1.w, r0.x, c1.y
cmp r0.y, r0, c0.z, c0.w
abs_pp r0.y, r0
mov r0.w, r2.y
add r1.y, r2.x, c2
cmp r1.z, r0, c0, c0.w
cmp_pp r0.y, -r0, c0.w, c0.z
mul_pp r1.x, r0.y, r1.z
cmp r0.z, -r1.x, r2.x, r1.y
mul r2.xy, r0.zwzw, c2.z
cmp r0.zw, -r1.x, r0, r2.xyxy
abs_pp r1.z, r1
cmp_pp r1.z, -r1, c0.w, c0
mul_pp r0.y, r0, r1.z
cmp r1.w, r1, c0.z, c0
mul_pp r1.z, r0.y, r1.w
mul r1.xy, r0.zwzw, c2.w
cmp r0.zw, -r1.z, r0, r1.xyxy
abs_pp r1.z, r1.w
add r1.w, r0.x, c1.z
cmp_pp r1.z, -r1, c0.w, c0
mul_pp r0.y, r0, r1.z
cmp r1.w, r1, c0.z, c0
mul_pp r1.z, r0.y, r1.w
mul r1.xy, r0.zwzw, c3.x
cmp r0.zw, -r1.z, r0, r1.xyxy
abs_pp r1.z, r1.w
add r1.w, r0.x, c1
cmp_pp r1.z, -r1, c0.w, c0
mul r1.xy, r0.zwzw, c3.y
mul_pp r0.y, r0, r1.z
cmp r1.w, r1, c0.z, c0
mul_pp r0.y, r0, r1.w
cmp r2.xy, -r0.y, r0.zwzw, r1
mad r0.z, r0.x, c4.x, c4.y
mov r1.y, c3.w
mov r1.x, r2
texld r1.x, r1, s0
log r0.y, r1.x
mad r0.y, r0, c5.x, c5
frc r0.y, r0
mad r0.y, r0, c4.z, c4.w
sincos r1.xy, r0.y
frc r0.z, r0
mad r0.y, r0.z, c4.z, c4.w
mul r0.zw, r2.xyxy, r1.y
sincos r4.xy, r0.y
mul r0.zw, r0, c5.z
mad r0.y, r0.w, c5.w, r4.x
mad r0.y, r0, c4.x, c4
mov r1.y, c3.z
mov r1.x, r2
texld r1.x, r1, s0
frc r1.y, r0
mad r0.y, r1.x, c4.x, c4
mad r2.x, r1.y, c4.z, c4.w
sincos r1.xy, r2.x
frc r0.y, r0
mad r0.y, r0, c4.z, c4.w
sincos r2.xy, r0.y
mad r0.y, r0.x, c6.x, c6
frc r0.y, r0
mad r2.z, r0.y, c4, c4.w
mad r2.x, r2.y, r1.y, r0.z
sincos r1.xy, r2.z
add r0.y, r2, c2.x
cmp r0.z, r0.y, r0, r2.x
mul r1.xy, r0.zwzw, r1.y
mov r1.z, c6
frc r2.xyz, r1
add r1.xyz, -r2, r1
mad r0.y, r1, c6.w, r1.x
mad r0.y, r1.z, c7.z, r0
add r0.w, r0.y, c8.y
add r0.z, r0.y, c7.w
mad r0.w, r0, c4.x, c4.y
mad r0.z, r0, c4.x, c4.y
frc r0.w, r0
mad r0.w, r0, c4.z, c4
sincos r1.xy, r0.w
mul r0.w, r1.y, c8.x
add r1.x, r0.y, c7.z
frc r0.z, r0
mad r0.z, r0, c4, c4.w
sincos r3.xy, r0.z
mul r0.z, r3.y, c8.x
mad r1.x, r1, c4, c4.y
frc r1.x, r1
mad r3.x, r1, c4.z, c4.w
sincos r1.xy, r3.x
mul r1.x, r1.y, c8
frc r1.y, r1.x
mad r1.x, -r2, c7, c7.y
frc r0.w, r0
frc r0.z, r0
add r2.w, r0.z, -r0
add r0.z, r0.y, c8
mad r0.z, r0, c4.x, c4.y
frc r0.z, r0
mad r0.z, r0, c4, c4.w
sincos r3.xy, r0.z
mul r0.z, r3.y, c8.x
frc r0.z, r0
add r1.z, r0, -r1.y
mul r0.z, r2.x, r2.x
mul r0.z, r0, r1.x
mad r2.x, r0.z, r1.z, r1.y
mad r0.w, r0.z, r2, r0
add r1.y, r0, c6.w
add r1.x, r0.y, c8.w
mad r1.y, r1, c4.x, c4
frc r1.y, r1
mad r1.x, r1, c4, c4.y
frc r1.x, r1
add r0.w, r0, -r2.x
mad r3.x, r1.y, c4.z, c4.w
mad r2.w, r1.x, c4.z, c4
sincos r1.xy, r3.x
sincos r3.xy, r2.w
mul r1.y, r1, c8.x
frc r1.z, r1.y
mul r1.x, r3.y, c8
frc r1.x, r1
add r1.w, r1.x, -r1.z
mad r1.y, -r2, c7.x, c7
mul r1.x, r2.y, r2.y
mul r2.y, r1.x, r1
mad r0.w, r2.y, r0, r2.x
mad r2.x, r0.z, r1.w, r1.z
add r1.x, r0.y, c0.w
mad r1.y, r0, c4.x, c4
mad r0.y, r1.x, c4.x, c4
frc r1.x, r1.y
frc r0.y, r0
mad r0.y, r0, c4.z, c4.w
sincos r3.xy, r0.y
mad r2.w, r1.x, c4.z, c4
sincos r1.xy, r2.w
mul r1.x, r1.y, c8
mul r0.y, r3, c8.x
frc r1.x, r1
frc r0.y, r0
add r1.y, r0, -r1.x
mad r0.z, r0, r1.y, r1.x
add r1.x, r2, -r0.z
mad r0.y, r2.z, c4.x, c4
frc r0.y, r0
mad r0.z, r2.y, r1.x, r0
mad r0.y, r0, c4.z, c4.w
sincos r1.xy, r0.y
add r0.y, r0.w, -r0.z
mad r2.y, r1, r0, r0.z
mul r0.y, r2, r4.x
mad r0.y, r0, c9.x, c9
frc r0.y, r0
mad r0.y, r0, c4.z, c4.w
sincos r1.xy, r0.y
mul r0.y, r1, c8.x
mad r0.z, r0.x, c9, c9.y
frc r2.x, r0.y
frc r0.y, r0.z
mad r0.z, r0.x, c10.y, c10
mad r0.x, r0.y, c4.z, c4.w
sincos r1.xy, r0.x
frc r0.y, r0.z
mad r1.y, r0, c4.z, c4.w
sincos r0.xy, r1.y
mul r0.y, r1.x, c9.w
mad r0.y, r2, c10.x, r0
mul r0.z, r0.x, c10.w
mad r0.x, r0.y, c4, c4.y
mad r0.y, r2, c10.x, r0.z
frc r0.x, r0
mad r0.x, r0, c4.z, c4.w
mad r0.y, r0, c4.x, c4
sincos r1.xy, r0.x
frc r0.y, r0
mad r1.x, r0.y, c4.z, c4.w
sincos r0.xy, r1.x
mul r0.x, r1.y, c8
mul r0.w, r0.y, c8.x
frc r2.y, r0.x
texld r0.xyz, v0, s0
frc r2.z, r0.w
mul oC0.xyz, r2, r0
mov oC0.w, c0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedcadaafcilbbillkpjdpglnnieefhjnpcabaaaaaakiaiaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaadadaaaafjaaaaaaaaaaaaaaabaaaaaa
adaaaaaaabaaaaaaapaaaaaagfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafeeffiedepepfceeaafdfgfpfaepfdejfeejepeoaaedepemepfcaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmmahaaaaeaaaaaaa
pdabaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaaddcbabaaaaaaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
efaaaaampcaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaiadpaaaaaaakpcaabaaaabaaaaaaegbebaaaaaaaaaaa
aceaaaaajkbjmiecaaaaaalpaaaaaalpaaaaaalpdiaaaaakpcaabaaaacaaaaaa
ogaobaaaabaaaaaaaceaaaaaaacepeeiaacepeeigclodmdigclodmdidhaaaaaj
gcaabaaaaaaaaaaafgafbaaaaaaaaaaakgalbaaaacaaaaaakgalbaaaabaaaaaa
dbaaaaakpcaabaaaadaaaaaaagaabaaaaaaaaaaaaceaaaaamnmmemdomnmmmmdo
jkjjbjdpmnmmemdpdhaaaaajgcaabaaaaaaaaaaapgapbaaaadaaaaaaagabbaaa
acaaaaaafgagbaaaaaaaaaaadiaaaaakpcaabaaaacaaaaaaegaobaaaabaaaaaa
aceaaaaabhlhfbdibhlhfbdipkonoldjpkonoldjdhaaaaajgcaabaaaaaaaaaaa
kgakbaaaadaaaaaakgalbaaaacaaaaaafgagbaaaaaaaaaaadhaaaaajgcaabaaa
aaaaaaaafgafbaaaadaaaaaaagabbaaaacaaaaaafgagbaaaaaaaaaaadhaaaaaj
dcaabaaaabaaaaaaagaabaaaadaaaaaaogakbaaaabaaaaaajgafbaaaaaaaaaaa
dgaaaaaimcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadoddddlddo
efaaaaajpcaabaaaacaaaaaaigaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaadaaaaaamgaabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaenaaaaagccaabaaaaaaaaaaaaanaaaaaakaabaaaadaaaaaa
cpaaaaafecaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaajomonneaenaaaaagecaabaaaaaaaaaaaaanaaaaa
ckaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaeieddiaaaaahgcaabaaaabaaaaaakgakbaaaaaaaaaaaagabbaaaabaaaaaa
enaaaaagaanaaaaaecaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaakhcaabaaa
acaaaaaaagaabaaaaaaaaaaaaceaaaaaaaaaddedaaaabaeaodmhfidpaaaaaaaa
dcaaaaajbcaabaaaaaaaaaaackaabaaaabaaaaaaabeaaaaaaaefbmehckaabaaa
aaaaaaaaenaaaaagbcaabaaaaaaaaaaaaanaaaaaakaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaabaaaaaa
dbaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaadpdhaaaaaj
bcaabaaaabaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaabaaaaaa
enaaaaagbcaabaaaaaaaaaaaaanaaaaaakaabaaaacaaaaaaenaaaaagaanaaaaa
kcaabaaaaaaaaaaafgajbaaaacaaaaaadiaaaaahdcaabaaaabaaaaaaagaabaaa
aaaaaaaaigaabaaaabaaaaaabkaaaaafmcaabaaaabaaaaaaagaebaaaabaaaaaa
ebaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaajbcaabaaaaaaaaaaa
bkaabaaaabaaaaaaabeaaaaaaaaagmecakaabaaaabaaaaaadiaaaaahdcaabaaa
abaaaaaaogakbaaaabaaaaaaogakbaaaabaaaaaadcaaaabamcaabaaaabaaaaaa
kgaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaeaaaaaaaea
aceaaaaaaaaaaaaaaaaaaaaaaaaaeaeaaaaaeaeadiaaaaahdcaabaaaabaaaaaa
ogakbaaaabaaaaaaegaabaaaabaaaaaaaaaaaaakhcaabaaaacaaaaaaagaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaagmecaaaahaecaaaaaaaaenaaaaagbcaabaaa
aaaaaaaaaanaaaaaakaabaaaaaaaaaaadiaaaaaklcaabaaaaaaaaaaaegambaaa
aaaaaaaaaceaaaaacnceclehmnmmmmdoaaaaaaaamnmmemdpbkaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaenaaaaaghcaabaaaacaaaaaaaanaaaaaegacbaaa
acaaaaaadiaaaaakhcaabaaaacaaaaaaegacbaaaacaaaaaaaceaaaaacncecleh
cnceclehcnceclehaaaaaaaabkaaaaafhcaabaaaacaaaaaaegacbaaaacaaaaaa
aaaaaaaiecaabaaaabaaaaaabkaabaiaebaaaaaaacaaaaaackaabaaaacaaaaaa
dcaaaaajecaabaaaabaaaaaaakaabaaaabaaaaaackaabaaaabaaaaaabkaabaaa
acaaaaaaaaaaaaaiicaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaa
acaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaabaaaaaa
akaabaaaaaaaaaaaaaaaaaaibcaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaa
ckaabaaaabaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaaaaaaaaaaadcaaaaamkcaabaaaaaaaaaaaagaabaaaaaaaaaaa
aceaaaaaaaaaaaaapjkamheaaaaaaaaapjkamheafganbaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaalcjnmheaenaaaaagbcaabaaaaaaaaaaa
aanaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaacnceclehbkaaaaafbcaabaaaabaaaaaaakaabaaaaaaaaaaaenaaaaag
dcaabaaaaaaaaaaaaanaaaaangafbaaaaaaaaaaadiaaaaakdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaaceaaaaacnceclehcnceclehaaaaaaaaaaaaaaaabkaaaaaf
gcaabaaaabaaaaaaagabbaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaiadpdoaaaaab"
}
}
 }
}
}