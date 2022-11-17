Shader "Custom/12_BlinnPhong"
{
    Properties
    {
        //_SpecColor => 예약어. 블린퐁사용시꼭 이대로만사용해야함
        
        _SpecColor ("Color", Color) = (1,1,1,1)

        _MainTex ("Albedo (RGB)", 2D) = "white" {}
       
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf BlinnPhong

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

      
       

      
        UNITY_INSTANCING_BUFFER_START(Props)
        
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutput o)
        {
           
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;

            //Specular size
            o.Specular = 0.5;

            //Specular Power
            o.Gloss = 1;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
