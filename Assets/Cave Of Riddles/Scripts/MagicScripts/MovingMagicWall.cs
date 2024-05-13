using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MovingMagicWall : MonoBehaviour
{
    public Transform startPoint; // ����� ������ ��������
    public Transform endPoint; // ����� ����� ��������
    public float speedStart = 0f; // �������� �������� ���������
    public float speedEnd = 0.5f;

    private bool movingToEnd = true; // ����, �����������, ��������� �� ��������� � �������� �����

    void Start()
    {
        // ��������� ��������� ������� ���������
        //transform.position = startPoint.position;
        startPoint.position = transform.position;
        endPoint.position = transform.position;
    }

    void Update()
    {
        // ��������� ����������� ��������
        //Vector3 direction = movingToEnd ? endPoint.position - startPoint.position : startPoint.position - endPoint.position;

        // ������������ ����������� ��� ��������� ��������
        //direction.Normalize();

        // �������� ���������
        transform.Translate(Vector3.up * speedStart * Time.deltaTime);

        // �������� ���������� �������� �����
        if (movingToEnd && Vector3.Distance(transform.position, endPoint.position) < 1f)
        {
            movingToEnd = false; // ����� ����������� ��������
        }
        else if (!movingToEnd && Vector3.Distance(transform.position, startPoint.position) < 0.1f)
        {
            movingToEnd = true; // ����� ����������� ��������
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

