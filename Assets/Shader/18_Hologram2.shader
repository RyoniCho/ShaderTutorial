Shader "Custom/18_Hologram2"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
   
       
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent"}
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Custom alpha:fade

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
            float3 viewDir;
            float3 worldPos;
        };

      
        fixed4 _Color;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutput o)
        {
          
           
            o.Emission=_Color;
            float rim = saturate(dot(IN.viewDir,o.Normal));
            rim= pow(frac(IN.worldPos.g-_Time.y),30)+pow((1-rim),10);
            o.Alpha = rim;
        }

        float4 LightingCustom(SurfaceOutput o, float3 lightDir,float atten)
        {
            return float4(0,0,0,o.Alpha);
        }
        ENDCG
    }
    FallBack "Tramsparent/Diffuse"
}
