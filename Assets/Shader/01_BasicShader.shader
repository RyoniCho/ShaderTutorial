Shader "Custom/01_BasicShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _TestProp("TestVector",Vector)=(0,0,0,0)
        _Bright("Brightness",Range(-1,1))=0
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

       

        struct Input
        {
            float4 color: COLOR;
        };

      
        fixed4 _Color;
        float _Bright;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)


        /*

        type:

        float>half>fixed


        //Basic struct SurfaceOutputStandard
        struct SurfaceOutputStandard
        {
            fixed3 Albedo;
            fixed3 Normal;
            fixed3 Emission;
            half Metallic;
            half Smoothness;
            half Occlusion;
            half Alpha;
        }


        */

        void surf (Input IN, inout SurfaceOutputStandard o)
        {

            //Albedo: related to Light Calculation color
            
            o.Albedo = _Color.rgb + _Bright;

            //Emission: Not related to Light Calculation
            //o.Emission= _Color; 

            
           
            o.Alpha = 1;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
