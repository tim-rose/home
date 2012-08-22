/*
 * BENCHMARK --Calculate benchmark statistics calculator.
 *
 * Remarks:
 * 
 * This program uses a bunch of hairy macros to run some typical-use
 * operations enough times to estimate the performance of the
 * processor/system.
 *
 * The values are probably not that significant by themselves, but
 * should be useful for comparitive analysis between two machines.
 *
 * This benchmark code is inspired from the "Performance" chapter of:
 * The Practice of Programming
 * Kernighan, Pike.
 * Addison Wesley (c) 1999
 * 
 * Routines:
 * bm_clock()   --Calculate the raw time of the last benchmark, in seconds.
 * bm_begin()  --Benchmark loop prologue.
 * bm_begin()  --Benchmark loop epilogue.
 * benchmark() --Print the duration of a task, in nanoseconds.
 * sum1()      --Return the sum of its (one!) argument.
 * sum2()      --Return the sum of two values.
 * sum3()      --Return the sum of three values.
 * main()      --Run a bunch of benchmarks, and report the results.
 *
 */
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <time.h>
#include <string.h>
#include <math.h>

#ifndef BM_MAX
  #define BM_MAX 1000000		/* No. of iterations to benchmark */
#endif /* BM_MAX */
#ifndef BM_THRESH
  #define BM_THRESH 3		/* max. allowed full/empty loop ratio */
#endif /* BM_THRESH */
static double bm_base; 		/* raw time of "no-task" loop */
static double bm_tvbase; 	/* raw tv-time of "no-task" loop */
static clock_t bm_t1, bm_t2;    /* clock-ticks for last benchmark */
static struct timeval bm_tv1, bm_tv2;

/*
 * bm_clock() --Calculate the raw time of the last benchmark, in seconds.
 */
#define bm_clock (((double)bm_t2-bm_t1)/CLOCKS_PER_SEC)

/*
 * bm_timeval() --Calculate the raw time of the last benchmark, in seconds.
 */
#define bm_timeval (((double)bm_tv2.tv_sec-bm_tv1.tv_sec)\
                    +((double)bm_tv2.tv_usec-bm_tv1.tv_usec)/1000000.0)

/*
 * bm_do_*() --Repeatedly do some task as a statement sequence.
 *
 * Remarks:
 * These are convenience macros for padding the benchmark loop
 * with "task" operations, without adding loop overhead.
 */
#define bm_do_5(_) _;_;_;_;_
#define bm_do_10(_) _;_;_;_;_;_;_;_;_;_
#define bm_do_20(_) _;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_
#define bm_do_50(_) \
    _;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_; \
    _;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_; \
    _;_;_;_;_;_;_;_;_;_
#define bm_do_100(_) \
    _;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_; \
    _;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_; \
    _;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_; \
    _;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_; \
    _;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_;_
#define bm_do_500(_500) \
    bm_do_100(_500); bm_do_100(_500); \
    bm_do_100(_500); bm_do_100(_500); bm_do_100(_500)    

/*
 * bm_begin() --Benchmark loop prologue.
 */
#define bm_begin \
    do {         \
        int bm_i;      \
        bm_t1 = clock(); gettimeofday(&bm_tv1, NULL); \
        for (bm_i=0; bm_i<BM_MAX; ++bm_i) {

/*
 * bm_begin() --Benchmark loop epilogue.
 */
#define bm_end \
        } \
        bm_t2 = clock(); gettimeofday(&bm_tv2, NULL); \
    } while (0)

/*
 * benchmark() --Print the duration of a task, in nanoseconds.
 *
 * Remarks:
 * If the run-time of the base test is too close to the empty-loop,
 * the test is re-run with "many" operations performed in the
 * inner loop, in an attempt to smooth out the effect of the loop code
 * on the overall benchmark time (i.e., to improve the accuracy of
 * the estimate).
 */
#define benchmark(name, init, task) \
    bm_begin; init; bm_end; \
    bm_base = bm_clock; bm_tvbase = bm_timeval; \
    do { \
        bm_begin; init; task; bm_end; \
        if (bm_clock/bm_base > BM_THRESH) { \
            printf("  %-35s %6.0fns %6.0fns\n", \
                   name, (1000*1000000/BM_MAX)*(bm_clock-bm_base), \
		   (1000*1000000/BM_MAX)*(bm_timeval-bm_tvbase)); \
        } else { \
            bm_begin; init; bm_do_100(task); bm_end; \
            printf("  %-35s %6.0fns %6.0fns (*)\n", \
                   name, (10*1000000/BM_MAX)*(bm_clock-bm_base), \
                   (10*1000000/BM_MAX)*(bm_timeval-bm_tvbase)); \
        } \
    } while (0)

/*
 * sum1() --Return the sum of its (one!) argument.
 * sum2() --Return the sum of two values.
 * sum3() --Return the sum of three values.
 *
 * Remarks:
 * These routines are used to test call/parameter-passing performance.
 */
static int sum1(int i1) { return i1; }
static int sum2(int i1, int i2) { return i1+i2; }
static int sum3(int i1, int i2, int i3) { return i1+i2+i3; }

/*
 * main() --Run a bunch of benchmarks, and report the results.
 *
 * Remarks:
 * The variables used in the benchmarks are declared "volatile"
 * to defeat compiler optimisations.
 */
int main(int argc, char *argv[])
{
    volatile int i1, i2, i3;
    volatile float f1, f2, f3;
    volatile double d1, d2, d3;
    volatile char *str1, *str2, *str3;
    volatile char strbuf[1024];
    volatile int v[100] = {0};
    FILE *fp;

    printf("%-35s %10s %10s\n", "Benchmark", "clock", "timeofday");
    
    printf("Integer:\n");
    benchmark("++i1", i1=0, ++i1);
    benchmark("i1 = i2 + i3", i2=987654321;i3=123456789, i1=i2+i3);
    benchmark("i1 = i2 - i3", i2=987654321;i3=123456789, i1=i2-i3);
    benchmark("i1 = i2 * i3", i2=987654321;i3=123456789, i1=i2*i3);
    benchmark("i1 = i2 / i3", i2=987654321;i3=123456789, i1=i2/i3);
    benchmark("i1 = i2 % i3", i2=987654321;i3=123456789, i1=i2%i3);

    printf("Float:\n");
    benchmark("f1 = f2 + f3", f2=987654321;f3=123456789, f3=f1+f2);
    benchmark("f1 = f2 - f3", f2=987654321;f3=123456789, f3=f1-f2);
    benchmark("f1 = f2 * f3", f2=987654321;f3=123456789, f3=f1*f2);
    benchmark("f1 = f2 / f3", f2=987654321;f3=123456789, f3=f1/f2);

#ifdef BENCH_DOUBLE
    printf("Double:\n");
    benchmark("d1 = d2 + d3", d2=987654321;d3=123456789, d3=d1+d2);
    benchmark("d1 = d2 - d3", d2=987654321;d3=123456789, d3=d1-d2);
    benchmark("d1 = d2 * d3", d2=987654321;d3=123456789, d3=d1*d2);
    benchmark("d1 = d2 / d3", d2=987654321;d3=123456789, d3=d1/d2);
#endif /* BENCH_DOUBLE */

    printf("Numeric Conversions:\n");
    benchmark("i1 = f1", i1=123456789;f1=123456789.0, i1=f1);
    benchmark("f1 = i1", i1=123456789;f1=123456789.0, f1=i1);

    printf("Vector:\n");
    benchmark("v[i] = i", i1=0, v[i1]=i1);
    benchmark("v[v[i]] = i", i1=0, v[v[i1]]=i1);
    benchmark("v[v[v[i]]] = i", i1=0, v[v[v[i1]]]=i1);

    printf("Control/Call:\n");
    benchmark("if (i == 5) { ++i1; }", i1=0;i2=0, if(i2 == 5){++i1;});
    benchmark("if (i != 5) { ++i1; }", i1=0;i2=0, if(i2 != 5){++i1;});
    benchmark("while (i < 0) { ++i1; }", i1=0;i2=5, while(i2<5){++i1;});
    benchmark("i1 = sum1(i1)", i1=1;i2=2;i3=0, i1=sum1(i1));
    benchmark("i1 = sum2(i1, i2)", i1=1;i2=2;i3=0, i1=sum2(i1, i2));
    benchmark("i1 = sum3(i1, i2, i3)", i1=1;i2=2;i3=0, i1=sum3(i1, i2, i3));

    printf("Math Library:\n");
    benchmark("i1 = rand()", i1=0, i1=rand());
    benchmark("f1 = sqrt(f2)", f1=0.5, f1=sqrt(f2));
    benchmark("f1 = exp(f2)", f1=0.5, f1=exp(f2));
    benchmark("f1 = log(f2)", f1=0.5, f1=log(f2));
    benchmark("f1 = sin(f2)", f1=1.0, f1=sin(f2));
    benchmark("f1 = cos(f2)", f1=1.0, f1=cos(f2));
    benchmark("f1 = tan(f2)", f1=1.0, f1=tan(f2));

    printf("String library:\n");
    str1 = (char *) "The quick brown fox jumps over the lazy dog";
    str2= (char *) "The quick brown fox jumps over the lazy dog";
    str3 = (char *) "Xhe quick brown fox jumps over the lazy dog";
    
    benchmark("strpy(s1, s2)", i1=0,
              (void)strcpy((char *)strbuf, (const char *)str1));
    benchmark("strcmp(==)", i1=0,
              i1=strcmp((const char *)str1,(const char *)str2));
    benchmark("strcmp(!=)", i1=0,
              i1=strcmp((const char *)str1,(const char *)str3));

    printf("String Conversions:\n");
    benchmark("i1 = atoi(\"123456789\")", i1=0, i1=atoi("123456789"));
    benchmark("sscanf(\"123456789\", \"%d\", &i1)",
              i1=0, sscanf("123456789", "%d", &i1));
    benchmark("sprintf(str, \"%d\", 123456789)",
              i1=123456789, sprintf((char *)strbuf, "%d", i1));
    benchmark("f1 = atof(\"123456789.0\")", f1=0, f1=atof("123456789.0"));
    benchmark("sscanf(\"123456789.0\", \"%f\", &f1)",
              f1=0.0, sscanf("123456789.0", "%f", &f1));
    benchmark("sprintf(str, \"%f\", 123456789.0)",
              f1=123456789.0, sprintf((char *)strbuf, "%f", f1));

    printf("Memory Allocation:\n");
    benchmark("free(malloc(8))", i1=0, free(malloc((8))));

    /*
     * Run the stdio benchmarks only if we can open a temporary file.
     */
    if ((fp = tmpfile()) != NULL)
    {
        char bm_title[1024];
        printf("Standard I/O:\n");

        rewind(fp);
        benchmark("fputs(str, fp)", i1=0, fputs((char*)str1,fp));
        rewind(fp);
        (void) sprintf(bm_title, "fgets(str, %lu, fp)", strlen((char*)str1));
        benchmark(bm_title, i1=0, fgets((char*)strbuf,43,fp));
        rewind(fp);
        benchmark("fprintf(fp, \"%d\\n\", i)",
                  i1=123456789, fprintf(fp,"%d\n",i1));
        rewind(fp);
        benchmark("fscanf(fp, \"%lu\", &i)",
                  i1=0, fprintf(fp,"%d",i1));
    }
    fclose(fp);
}
