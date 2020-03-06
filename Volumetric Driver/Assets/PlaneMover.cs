using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlaneMover : MonoBehaviour
{
	
	public float max = 0f;
	public float min = 0f;
	private float x = 0f;
    public Material mat;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        Vector4 vec = new Vector4(0f, Mathf.Sin(x), 0f, 0f);
        mat.SetVector("_PlanePosition", vec);
	     x += 0.1f;
         if (x > 2*Mathf.PI) x = 0f;
    }
}
