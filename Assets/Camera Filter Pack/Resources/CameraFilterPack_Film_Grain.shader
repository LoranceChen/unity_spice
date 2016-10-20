Shader "CameraFilterPack/Film_Grain" {
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
  float tmpvar_1;
  tmpvar_1 = (((xlv_TEXCOORD0.x + 4.0) * (xlv_TEXCOORD0.y + 4.0)) * (_TimeX * 10.0));
  float x_2;
  x_2 = (((tmpvar_1 - (floor((tmpvar_1 * 0.0769231)) * 13.0)) + 1.0) * ((tmpvar_1 - (floor((tmpvar_1 * 0.00813008)) * 123.0)) + 1.0));
  gl_FragData[0] = (texture2D (_MainTex, xlv_TEXCOORD0) + (vec4(((x_2 - (floor((x_2 * 100.0)) * 0.01)) - 0.005)) * _Value));
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
; 22 ALU, 1 TEX
dcl_2d s0
def c2, 4.00000000, 10.00000000, 0.07692308, 0.00813008
def c3, 13.00000000, 1.00000000, 123.00000000, 100.00000000
def c4, 0.01000000, -0.00500000, 0, 0
dcl_texcoord0 v0.xy
add r0.y, v0, c2.x
add r0.x, v0, c2
mul r0.x, r0, r0.y
mul r0.x, r0, c0
mul r0.x, r0, c2.y
mul r0.w, r0.x, c2
mul r0.y, r0.x, c2.z
frc r1.x, r0.w
frc r0.z, r0.y
add r0.w, r0, -r1.x
add r0.y, r0, -r0.z
mad r0.z, -r0.w, c3, r0.x
mad r0.x, -r0.y, c3, r0
add r0.y, r0.z, c3
add r0.x, r0, c3.y
mul r0.x, r0, r0.y
mul r0.y, r0.x, c3.w
frc r0.z, r0.y
add r0.y, r0, -r0.z
mad r1.x, -r0.y, c4, r0
texld r0, v0, s0
add r1.x, r1, c4.y
mad oC0, r1.x, c1.x, r0
"
}
}
 }
}
}