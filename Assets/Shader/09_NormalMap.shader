Shader "Custom/09_NormalMap"
{
    Properties
    {
      
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _NormalTex ("Normal", 2D) = "bump" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _NormalTex;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_NormalTex;
        };

        half _Glossiness;
        half _Metallic;
        

       
        UNITY_INSTANCING_BUFFER_START(Props)
        
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
          
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            fixed4 d = tex2D (_NormalTex, IN.uv_NormalTex);
            half3 n = UnpackNormal(d);

            o.Albedo = c.rgb;
            o.Normal = n;
           
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
