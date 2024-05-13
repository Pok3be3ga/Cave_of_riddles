using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ColorFlicker : MonoBehaviour
{
    public Color targetColor; // Целевой цвет объекта
    public float flickerDuration = 1f; // Длительность мигания объекта
    public int flickerCount = 3; // Количество повторений мигания
    public float returnDuration = 0.5f; // Длительность возвращения к начальному цвету
    public Renderer objectRenderer; // Ссылка на компонент Renderer объекта

    private Color initialColor; // Начальный цвет объекта
    private int flickerIndex; // Текущий индекс мигания
    private bool isFlickering; // Флаг, указывающий на то, что объект в данный момент мигает

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
            // Вычисляем прогресс мигания от 0 до 1
            float flickerProgress = Mathf.PingPong(Time.time, flickerDuration) / flickerDuration;

            // Изменяем цвет и прозрачность объекта на основе прогресса мигания
            objectRenderer.material.color = Color.Lerp(initialColor, targetColor, flickerProgress);

            // Проверяем, закончилось ли текущее мигание
            if (flickerProgress >= 1f)
            {
                flickerIndex++;

                // Проверяем, достигнуто ли количество повторений мигания
                if (flickerIndex >= flickerCount)
                {
                    // Запускаем корутину для плавного возвращения к начальному цвету
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

        // Сбрасываем значения
        flickerIndex = 0;
        isFlickering = false;
        objectRenderer.material.color = initialColor;

        // Запускаем следующий цикл мигания
        StartFlicker();
    }
}