using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CheckDistance : MonoBehaviour
{
    public bool ActivateBool;
    private void Start()
    {
        gameObject.SetActive(ActivateBool);
    }
    public void Activate()
    {
        gameObject.SetActive(true);
    }
    public void Deactivate()
    {
        gameObject.SetActive(false);
    }
}
