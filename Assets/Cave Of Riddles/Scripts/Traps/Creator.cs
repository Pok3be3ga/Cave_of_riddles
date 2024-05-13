using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class Creator : MonoBehaviour
{
    public Transform Trap;
    public GameObject SpearPrefab;
    public Transform Spawn;
    public Transform SpawnRotation;
    public float Speed = 5f;
    public AudioSource audioSource;
    
    float timerKd = 1f;
    [SerializeField] float _timer;
    [SerializeField] Transform _playerTransform;

    [ContextMenu("find player transform")]
    public void PlayerTransform()
    {
        _playerTransform = FindObjectOfType<PlayerVR>().transform;
    }

    private void FixedUpdate()
    {
        Vector3 toPlayer = _playerTransform.position - transform.position;
        Trap.rotation = Quaternion.LookRotation(toPlayer);
    }

    private void Start()
    {
        _timer = 0f;
    }

    void Update()
    {
        _timer += Time.deltaTime;
    }

    public void ForSecondCreate()
    {
        if(_timer > timerKd)
            {
            _timer = 0;
            Invoke("Create", 0.5f);
            audioSource.Play();
            }
        
    }


    public void Create()
    {
            GameObject newSpear = Instantiate(SpearPrefab, Spawn.position, SpawnRotation.rotation);
    }
    
}
