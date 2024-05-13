using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RotationSphere : MonoBehaviour
{
    public float Speed = 100f;
    public Vector3 Rotation = Vector3.up;

    void Update()
    {
        transform.Rotate(Rotation, Speed * Time.deltaTime);
    }
}
