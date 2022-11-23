Shader "Custom/19_BlinnPhong_custom"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
      
        _SpecCol ("SpecColor", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Custom noambient

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

      
        fixed4 _Color;
        fixed4 _SpecCol;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutput o)
        {
           
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }

        float4 LightingCustom(SurfaceOutput s, float3 lightDir, float3 viewDir, float atten)
        {
            float4 final;

            //Lambert
            float nDot = saturate(dot(s.Normal,lightDir));
            float3 diffColor= nDot*s.Albedo*_LightColor0.rgb*atten;

            //Specular- Blinn phong
            float3 halfVec=normalize(lightDir+viewDir);
            float spec=saturate(dot(s.Normal,halfVec));
            spec=pow(spec,100);

            float3 specColor=_SpecCol.rgb*spec;

            final.rgb=diffColor.rgb+specColor.rgb;
            final.a=s.Alpha;
            return final;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
