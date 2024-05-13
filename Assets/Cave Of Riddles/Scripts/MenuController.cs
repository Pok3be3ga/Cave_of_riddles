using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class MenuController : MonoBehaviour
{
    public void StartBtn()
    {
        SceneManager.LoadScene("Level Full 1");
    }

    public void InvokeScene()
    {
        Invoke("VictoriScene", 3);
    }
    public void VictoriScene()
    {
        SceneManager.LoadScene("MenuVictory");
    }
}
