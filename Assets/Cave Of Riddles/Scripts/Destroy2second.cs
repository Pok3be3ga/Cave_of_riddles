using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Destroy2second : MonoBehaviour
{
    public float TimeDestroy = 3;
    public void Destroy()
    {
        Destroy(gameObject, TimeDestroy);
    }

}
