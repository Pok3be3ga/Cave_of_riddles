using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AutoRotateObject : MonoBehaviour
{
    public float X = 0;
    public float Y = 10f;
    public float Z = 0;// Скорость вращения
    private Rigidbody rb; // Ссылка на компонент Rigidbody

    void Start()
    {
        rb = GetComponent<Rigidbody>(); // Получаем компонент Rigidbody
    }

    void FixedUpdate()
    {
        // Создаем кватернион поворота вокруг оси Y с заданной скоростью
        Quaternion rotation = Quaternion.Euler(X * Time.fixedDeltaTime, Y * Time.fixedDeltaTime, Z * Time.fixedDeltaTime) * rb.rotation;

        // Вращаем Rigidbody с помощью созданного кватерниона поворота
        rb.MoveRotation(rotation);
    }
}

