using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HealthPlayer : MonoBehaviour
{
    public GameObject HealthIconPrefab;
    public List<GameObject> HealthIcon = new List<GameObject>();

    public void Setup(int MaxHealth)
    {
        for (float i = 0; i < 1; i++)
        {
            //GameObject newIcon  =  Instantiate(HealthIconPrefab, transform);
            HealthIcon.AddRange(GameObject.FindGameObjectsWithTag("Health"));

        }
    }

    public void DisplayHealth(int Health)
    {
        for (int i = 0; i < HealthIcon.Count; i++)
        {
            if(i < Health)
            {
                HealthIcon[i].SetActive(true);
            }
            else
            {
                HealthIcon[i].SetActive(false);
            }
        }
    }
}
