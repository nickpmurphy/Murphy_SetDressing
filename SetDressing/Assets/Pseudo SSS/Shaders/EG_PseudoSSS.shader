// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Shader created with Shader Forge v1.36 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.36;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9399,x:33657,y:32632,varname:node_9399,prsc:2|custl-8078-OUT;n:type:ShaderForge.SFN_NormalVector,id:1270,x:32115,y:32779,prsc:2,pt:False;n:type:ShaderForge.SFN_LightVector,id:5456,x:32115,y:32922,varname:node_5456,prsc:2;n:type:ShaderForge.SFN_ViewVector,id:7367,x:32115,y:33046,varname:node_7367,prsc:2;n:type:ShaderForge.SFN_Dot,id:4616,x:32290,y:32779,varname:node_4616,prsc:2,dt:0|A-1270-OUT,B-5456-OUT;n:type:ShaderForge.SFN_Dot,id:1433,x:32290,y:32922,varname:node_1433,prsc:2,dt:0|A-1270-OUT,B-7367-OUT;n:type:ShaderForge.SFN_Multiply,id:2206,x:32468,y:32779,varname:node_2206,prsc:2|A-4616-OUT,B-4092-OUT;n:type:ShaderForge.SFN_Multiply,id:8998,x:32468,y:32955,varname:node_8998,prsc:2|A-1433-OUT,B-1570-OUT;n:type:ShaderForge.SFN_Vector1,id:4092,x:32468,y:32900,varname:node_4092,prsc:2,v1:0.3;n:type:ShaderForge.SFN_Vector1,id:1570,x:32468,y:33076,varname:node_1570,prsc:2,v1:0.8;n:type:ShaderForge.SFN_Add,id:2793,x:32680,y:32779,varname:node_2793,prsc:2|A-2206-OUT,B-2935-OUT;n:type:ShaderForge.SFN_Vector1,id:2935,x:32680,y:32900,varname:node_2935,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Append,id:5767,x:32902,y:32900,varname:node_5767,prsc:2|A-8998-OUT,B-2793-OUT;n:type:ShaderForge.SFN_Tex2d,id:7419,x:33076,y:32900,varname:node_7419,prsc:2,tex:10ac76cf74b4544229c2f431309ec1bc,ntxv:0,isnm:False|UVIN-5767-OUT,TEX-4751-TEX;n:type:ShaderForge.SFN_Tex2dAsset,id:4751,x:32902,y:33049,ptovrint:False,ptlb:ramp,ptin:_ramp,varname:node_4751,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:10ac76cf74b4544229c2f431309ec1bc,ntxv:0,isnm:False;n:type:ShaderForge.SFN_LightColor,id:2,x:33076,y:33021,varname:node_2,prsc:2;n:type:ShaderForge.SFN_LightAttenuation,id:8711,x:33076,y:33144,varname:node_8711,prsc:2;n:type:ShaderForge.SFN_Multiply,id:5902,x:33290,y:32953,varname:node_5902,prsc:2|A-7419-RGB,B-2-RGB,C-8711-OUT;n:type:ShaderForge.SFN_VertexColor,id:738,x:33076,y:33269,varname:node_738,prsc:2;n:type:ShaderForge.SFN_Multiply,id:8078,x:33290,y:33086,varname:node_8078,prsc:2|A-5902-OUT,B-738-R;proporder:4751;pass:END;sub:END;*/

Shader "Ethan Gross/EG_PseudoSSS" {
    Properties {
        _ramp ("ramp", 2D) = "white" {}
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 glcore gles 
            #pragma target 3.0
            uniform sampler2D _ramp; uniform float4 _ramp_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                float4 vertexColor : COLOR;
                LIGHTING_COORDS(2,3)
                UNITY_FOG_COORDS(4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.vertexColor = v.vertexColor;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos(v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float2 node_5767 = float2((dot(i.normalDir,viewDirection)*0.8),((dot(i.normalDir,lightDirection)*0.3)+0.5));
                float4 node_7419 = tex2D(_ramp,TRANSFORM_TEX(node_5767, _ramp));
                float3 finalColor = ((node_7419.rgb*_LightColor0.rgb*attenuation)*i.vertexColor.r);
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 glcore gles 
            #pragma target 3.0
            uniform sampler2D _ramp; uniform float4 _ramp_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                float4 vertexColor : COLOR;
                LIGHTING_COORDS(2,3)
                UNITY_FOG_COORDS(4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.vertexColor = v.vertexColor;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos(v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float2 node_5767 = float2((dot(i.normalDir,viewDirection)*0.8),((dot(i.normalDir,lightDirection)*0.3)+0.5));
                float4 node_7419 = tex2D(_ramp,TRANSFORM_TEX(node_5767, _ramp));
                float3 finalColor = ((node_7419.rgb*_LightColor0.rgb*attenuation)*i.vertexColor.r);
                fixed4 finalRGBA = fixed4(finalColor * 1,0);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
