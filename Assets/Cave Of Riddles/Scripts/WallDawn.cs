using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WallDawn : MonoBehaviour
{
    public float movementSpeedUp = 0f;
    public float movementSpeedDawn = 0f; // �������� ��������
    public float distance = 3f; // ���������� ��� ��������

    private Vector3 initialPosition; // ��������� ������� �������

    void Start()
    {
        initialPosition = transform.position; // ��������� ��������� ������� �������
    }

    void Update()
    {
        Vector3 Distance = new Vector3(0, distance, 0);

        Vector3 initialPosition2 = initialPosition + Distance;
        transform.position = Vector3.Lerp(transform.position, initialPosition2, Time.deltaTime * movementSpeedUp);


       
        Vector3 initialPosition3 = initialPosition - Distance;
        transform.position = Vector3.Lerp(transform.position, initialPosition3, Time.deltaTime * movementSpeedDawn);
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

