using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ConvertAudio : MonoBehaviour {
    public float mag = 0.5f;
    public float lowMag;
    public float highMag;
    public float noiseScale;
    public float lerpSpeed;

	Renderer rend;
    ParticleSystem ps;

	void Start () {
		rend = GetComponent<Renderer> ();
        ps = GetComponent<ParticleSystem>();
	}
	

	void Update () {

        if (Input.GetKeyDown(KeyCode.Escape))
        {
            Application.Quit();
        }

        if (Input.GetKeyDown(KeyCode.UpArrow))
        {
            noiseScale = Mathf.Min(20f, noiseScale + 1f);
        }
        else if (Input.GetKeyDown(KeyCode.DownArrow))
        {
            noiseScale = Mathf.Max(0f, noiseScale - 1f);
        }

        int numPartitions = 1;
		float[] aveMag = new float[numPartitions];
		float partitionIndx = 0;
		int numDisplayedBins = 512 / 2; 

		for (int i = 0; i < numDisplayedBins; i++) 
		{
			if(i < numDisplayedBins * (partitionIndx + 1) / numPartitions){
				aveMag[(int)partitionIndx] += AudioPeer.spectrumData [i] / (512/numPartitions);
			}
			else{
				partitionIndx++;
				i--;
			}
		}

		for(int i = 0; i < numPartitions; i++)
		{
			aveMag[i] = aveMag[i]*1000;
			if (aveMag[i] > 100) {
				aveMag[i] = 100;
			}
		}

		float newMag = Mathf.Max(lowMag, Mathf.Min(highMag, aveMag[0]));
        newMag -= lowMag;
        newMag /= (highMag - lowMag);
        mag = Mathf.Lerp(mag, newMag, Time.deltaTime * lerpSpeed);
        rend.material.SetFloat("_LerpValue", mag);

        var noise = ps.noise;
        noise.strength = noiseScale * mag;
	}


}

