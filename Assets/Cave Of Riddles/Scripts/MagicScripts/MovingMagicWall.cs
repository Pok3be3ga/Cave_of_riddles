using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MovingMagicWall : MonoBehaviour
{
    public Transform startPoint; // Точка начала движения
    public Transform endPoint; // Точка конца движения
    public float speedStart = 0f; // Скорость движения платформы
    public float speedEnd = 0.5f;

    private bool movingToEnd = true; // Флаг, указывающий, двигается ли платформа к конечной точке

    void Start()
    {
        // Установка начальной позиции платформы
        //transform.position = startPoint.position;
        startPoint.position = transform.position;
        endPoint.position = transform.position;
    }

    void Update()
    {
        // Получение направления движения
        //Vector3 direction = movingToEnd ? endPoint.position - startPoint.position : startPoint.position - endPoint.position;

        // Нормализация направления для единичной скорости
        //direction.Normalize();

        // Движение платформы
        transform.Translate(Vector3.up * speedStart * Time.deltaTime);

        // Проверка достижения конечной точки
        if (movingToEnd && Vector3.Distance(transform.position, endPoint.position) < 1f)
        {
            movingToEnd = false; // Смена направления движения
        }
        else if (!movingToEnd && Vector3.Distance(transform.position, startPoint.position) < 0.1f)
        {
            movingToEnd = true; // Смена направления движения
        }
    }
    public void Moving()
    {
        speedStart += speedEnd;
    }
    public void Back()
    {
        transform.position = startPoint.position;
    }
    public void DontMoving()
    {
        speedStart = 0;
        transform.position = startPoint.position;
    }
}

