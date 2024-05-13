using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MovingPlatformColider : MonoBehaviour
{
    public Transform startPoint; // Точка начала движения
    public Transform endPoint; // Точка конца движения
    public float speedStart = 0f; // Скорость движения платформы
    public float speedEnd = 0.5f;

    [SerializeField] private bool movingToEnd = true; // Флаг, указывающий, двигается ли платформа к конечной точке

    void Start()
    {
        transform.position = startPoint.position;
    }

    void Update()
    {
        // Движение платформы
       
        if(movingToEnd == true)
        {
           // GetComponent<Rigidbody>().MovePosition(startPoint.position + endPoint.position * speedStart);
            transform.position = Vector3.MoveTowards(transform.position, endPoint.position, Time.deltaTime * speedStart);
        }
        if(movingToEnd == false)
        {
            //GetComponent<Rigidbody>().MovePosition(endPoint.position + startPoint.position * speedStart);
           transform.position = Vector3.MoveTowards(transform.position, startPoint.position, Time.deltaTime * speedStart);
        }

        // Проверка достижения конечной точки
        if (movingToEnd && Vector3.Distance(transform.position, endPoint.position) < 1f)
        {
            
            movingToEnd = false; // Смена направления движения
        }
        else if (!movingToEnd && Vector3.Distance(transform.position, startPoint.position) < 1f)
        {
            movingToEnd = true; // Смена направления движения
        }
    }
    public void Moving()
    {
        speedStart = speedEnd;
    }
    public void Back()
    {
        transform.position = startPoint.position;
    }
    public void DontMoving()
    {
        speedStart = 0;
    }
}

