using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TrapDawnUp : MonoBehaviour
{
    public float movementSpeedUp = 0f;
    public float movementSpeedDawn = 0f; // Скорость движения
    public float X = 0f;
    public float Y = 3f;
    public float Z = 0f;// Расстояние для движения

    public float T1 = 3;
    public float T2 = 6;

    [SerializeField] private float _timer;
    private Vector3 initialPosition; // Начальная позиция объекта

    void Start()
    {
        initialPosition = transform.position; // Сохраняем начальную позицию объекта
    }

    void Update()
    {
        _timer += Time.deltaTime;
        Vector3 Distance = new Vector3(X, Y, Z);

        if (_timer > 0 && _timer < T1)
        {
            Vector3 initialPosition2 = initialPosition + Distance;
            transform.position = Vector3.Lerp(transform.position, initialPosition2, Time.deltaTime * movementSpeedUp);
        }
        if (_timer > 3)
        {
            Vector3 initialPosition3 = initialPosition - Distance;
            transform.position = Vector3.Lerp(transform.position, initialPosition3, Time.deltaTime * movementSpeedDawn);
            if(_timer > T2)
            {
                _timer = 0;
            }
        }

        


       
        
    }

    public void MoveDown()
    {
        movementSpeedDawn = 1;
    }

    public void MoveUp()
    {
        movementSpeedUp = 1;
    }
}

