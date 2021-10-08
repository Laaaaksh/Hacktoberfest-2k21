// Dart program for implementation of KMP pattern searching
// algorithm

// Fills lps[] for given patttern pat[0..M-1]
void computeLPSArray(String pattern, int M, List<int> lps)
{
	// length of the previous longest prefix suffix
	int len = 0;

	lps[0] = 0; // lps[0] is always 0

	// the loop calculates lps[i] for i = 1 to M-1
	int i = 1;
	while (i < M) {
		if (pattern[i] == pattern[len]) {
			len++;
			lps[i] = len;
			i++;
		}
		else // (pat[i] != pat[len])
		{
			// This is tricky. Consider the example.
			// AAACAAAA and i = 7. The idea is similar
			// to search step.
			if (len != 0) {
				len = lps[len - 1];

				// Also, note that we do not increment
				// i here
			}
			else // if (len == 0)
			{
				lps[i] = 0;
				i++;
			}
		}
	}
}

// Prints occurrences of txt[] in pat[]
void KMPSearch(String pattern, String text)
{
	int M = pattern.length;
	int N = text.length; 

	// create lps[] that will hold the longest prefix suffix
	// values for pattern
	var lps = List<int>.filled(M, 0);

	// Preprocess the pattern (calculate lps[] array)
	computeLPSArray(pattern, M, lps);

	int i = 0; // index for txt[]
	int j = 0; // index for pat[]
	while (i < N) {
		if (pattern[j] == text[i]) {
			j++;
			i++;
		}

		if (j == M) {
			print("Found pattern at index ${i - j}");
			j = lps[j - 1];
		}

		// mismatch after j matches
		else if (i < N && pattern[j] != text[i]) {
			// Do not match lps[0..lps[j-1]] characters,
			// they will match anyway
			if (j != 0){
        	j = lps[j - 1];
      }
			else{
        i = i + 1;
      }
		}
	}
}

// Driver program to test above function
void main()
{
	String text = "Hacktoberfest";
	String pattern = "ober";
	KMPSearch(pattern, text);
}

