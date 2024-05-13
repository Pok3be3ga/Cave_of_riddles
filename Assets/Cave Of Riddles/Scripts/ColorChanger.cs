using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ColorFlicker : MonoBehaviour
{
    public Color targetColor; // ������� ���� �������
    public float flickerDuration = 1f; // ������������ ������� �������
    public int flickerCount = 3; // ���������� ���������� �������
    public float returnDuration = 0.5f; // ������������ ����������� � ���������� �����
    public Renderer objectRenderer; // ������ �� ��������� Renderer �������

    private Color initialColor; // ��������� ���� �������
    private int flickerIndex; // ������� ������ �������
    private bool isFlickering; // ����, ����������� �� ��, ��� ������ � ������ ������ ������

    private void Start()
    {
        if (objectRenderer == null)
        {
            objectRenderer = GetComponent<Renderer>();
        }

        initialColor = objectRenderer.material.color;
        flickerIndex = 0;
        isFlickering = false;

        StartFlicker();
    }

    private void Update()
    {
        if (isFlickering)
        {
            // ��������� �������� ������� �� 0 �� 1
            float flickerProgress = Mathf.PingPong(Time.time, flickerDuration) / flickerDuration;

            // �������� ���� � ������������ ������� �� ������ ��������� �������
            objectRenderer.material.color = Color.Lerp(initialColor, targetColor, flickerProgress);

            // ���������, ����������� �� ������� �������
            if (flickerProgress >= 1f)
            {
                flickerIndex++;

                // ���������, ���������� �� ���������� ���������� �������
                if (flickerIndex >= flickerCount)
                {
                    // ��������� �������� ��� �������� ����������� � ���������� �����
                    StartCoroutine(ReturnToInitialColor());
                    return;
                }
            }
        }
    }

    private void StartFlicker()
    {
        isFlickering = true;
    }

    private IEnumerator ReturnToInitialColor()
    {
        isFlickering = false;

        float returnProgress = 0f;

        while (returnProgress < 1f)
        {
            returnProgress += Time.deltaTime / returnDuration;
            objectRenderer.material.color = Color.Lerp(targetColor, initialColor, returnProgress);
            yield return null;
        }

        // ���������� ��������
        flickerIndex = 0;
        isFlickering = false;
        objectRenderer.material.color = initialColor;

        // ��������� ��������� ���� �������
        StartFlicker();
    }
}