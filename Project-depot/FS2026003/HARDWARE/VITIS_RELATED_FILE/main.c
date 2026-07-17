
#include "xgpio.h"
#include "xparameters.h"
#include "xil_printf.h"


#define GPIO_CHANNEL 1

int main()
{
    XGpio start_gpio;
    XGpio done_gpio;
    XGpio mae_gpio;

    int done;
    int mae;

    xil_printf("California FPGA Start\r\n");

XGpio_Config *cfg;

cfg = XGpio_LookupConfig(XPAR_XGPIO_0_BASEADDR);
XGpio_CfgInitialize(&start_gpio, cfg, cfg->BaseAddress);

cfg = XGpio_LookupConfig(XPAR_XGPIO_1_BASEADDR);
XGpio_CfgInitialize(&done_gpio, cfg, cfg->BaseAddress);

cfg = XGpio_LookupConfig(XPAR_XGPIO_2_BASEADDR);
XGpio_CfgInitialize(&mae_gpio, cfg, cfg->BaseAddress);

    // Direction setup
    // 0 = output, 1 = input
    XGpio_SetDataDirection(&start_gpio, GPIO_CHANNEL, 0x0);
    XGpio_SetDataDirection(&done_gpio, GPIO_CHANNEL, 0xFFFFFFFF);
    XGpio_SetDataDirection(&mae_gpio, GPIO_CHANNEL, 0xFFFFFFFF);


    // Generate start pulse
    xil_printf("Sending start pulse\r\n");

    XGpio_DiscreteWrite(&start_gpio, GPIO_CHANNEL, 1);

    for(volatile int i = 0; i < 100000; i++);

    XGpio_DiscreteWrite(&start_gpio, GPIO_CHANNEL, 0);


    // Wait for done
    xil_printf("Waiting for done...\r\n");

    do
    {
        done = XGpio_DiscreteRead(&done_gpio, GPIO_CHANNEL);
    }
    while(done == 0);


    // Read MAE
    mae = XGpio_DiscreteRead(&mae_gpio, GPIO_CHANNEL);

    xil_printf("Done!\r\n");
    xil_printf("MAE = %d\r\n", mae);


    return 0;
}