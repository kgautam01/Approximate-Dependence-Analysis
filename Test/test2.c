#include <stdio.h>
int main()
{
    int c = 100;
    int arr[100];
    int brr[100];
    for(int i = 0; i < 100; i++)
    {
        arr[i] = arr[i-1] + c;
        for(int j = 0; j < 100; j++)
        {
            brr[j] = arr[i];
            brr[j-2] = brr[j] + c; 
        }
    }
    return 0;
}
