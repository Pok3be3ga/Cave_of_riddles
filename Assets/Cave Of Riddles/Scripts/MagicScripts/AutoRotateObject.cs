using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AutoRotateObject : MonoBehaviour
{
    public float X = 0;
    public float Y = 10f;
    public float Z = 0;// �������� ��������
    private Rigidbody rb; // ������ �� ��������� Rigidbody

    void Start()
    {
        rb = GetComponent<Rigidbody>(); // �������� ��������� Rigidbody
    }

    void FixedUpdate()
    {
        // ������� ���������� �������� ������ ��� Y � �������� ���������
        Quaternion rotation = Quaternion.Euler(X * Time.fixedDeltaTime, Y * Time.fixedDeltaTime, Z * Time.fixedDeltaTime) * rb.rotation;

        // ������� Rigidbody � ������� ���������� ����������� ��������
        rb.MoveRotation(rotation);
    }
}

