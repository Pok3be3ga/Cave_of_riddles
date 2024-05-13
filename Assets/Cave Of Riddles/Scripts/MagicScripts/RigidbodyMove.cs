    using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RigidbodyMove : MonoBehaviour
{
    public Transform StartPosition;
    public Transform FinishPosition;
    public float Speed;
    public float SpeedGO;

    Rigidbody _rigidbody;
    public bool _movingToEnd = true;

    void Start()
    {
        _rigidbody = GetComponent<Rigidbody>();
    }

    // Update is called once per frame
    void Update()
    {
        if (Vector3.Distance(transform.position, StartPosition.position) < 1f)
        {
            _movingToEnd = true;
        }
        if (Vector3.Distance(transform.position, FinishPosition.position) < 1f) 
        {
            _movingToEnd = false;
        }

        if (_movingToEnd == false)
        {
            Vector3 _moveVector = StartPosition.position - FinishPosition.position;
            _rigidbody.AddForce(_moveVector * Speed, ForceMode.VelocityChange);
        }
        if (_movingToEnd == true)
        {
            {
                Vector3 _moveVector = FinishPosition.position - StartPosition.position;
                _rigidbody.AddForce(_moveVector * Speed, ForceMode.VelocityChange);
            }

        }

    }

    public void GO()
    {
        Speed = SpeedGO;
    }

    private void FixedUpdate()
    {
       
    }
}
