using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Emission : MonoBehaviour
{
    public Material M1;
    public Material M2;
    public Material M3;
    public float Timer;

    public Color emissionColor = Color.red;
    void Start()
    {

    }
    void Update()
    {
        Timer = Timer + Time.deltaTime;

        if(Timer > 1)
        {
            Timer = 0;
        }
        if (Timer < 0.5)
       {
            M3.color = Color.Lerp(M1.color, M2.color, Timer);
        }
        if(Timer > 0.5)
        {
            M3.color = Color.Lerp(M2.color, M1.color, Timer);
        }



        Color emissionColor = Color.Lerp(M1.color, M2.color, Timer); ;
        M3.EnableKeyword("_EMISSION");
        M3.SetColor("_EmissionColor", emissionColor);
    }



}
