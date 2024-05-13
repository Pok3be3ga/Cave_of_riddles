using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Spear : MonoBehaviour
{

    public float _timer;
    public AudioSource CreateSound;
    private void Start()
    {
        CreateSound.Play();
    }

    void Update()
    {
        _timer += Time.deltaTime;
        if (_timer >= 5)
        {
            Die();
        }
    }

    private void Die()
    {
        Destroy(gameObject);
    }
}
