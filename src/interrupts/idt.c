#include <stdint.h>
#include "idt.h"

#define IDT_SIZE 512 // or 2048

void divideByZeroISR();

struct IDTDescriptor{
    uint16_t handlerLow; // lower 16 bits of ISR address
    uint16_t kernelCodeSelector;
    uint8_t ist; // interrupt stack table index
    uint8_t options; // descriptor type and attributes
    uint16_t handlerMiddle; // middle 16 bits of ISR address
    uint32_t handlerHigh; // upper 32 bits of ISR address
    uint32_t reserved; // reserved, set to 0
} __attribute__((packed));;

struct IDTR{
    uint16_t size;
    uint64_t address;
} idtr;

struct IDTDescriptor idt[IDT_SIZE];
struct IDTR idtr;

void initIDTEntry(struct IDTDescriptor* desc, void* isrHandler){
    desc->handlerLow = (uint64_t)isrHandler & 0xFFFF;
    desc->handlerMiddle = (uint64_t)isrHandler >> 16 & 0xFFFF;
    desc->handlerHigh = (uint64_t)isrHandler >> 32;
    desc->kernelCodeSelector = 0x08;
    desc->ist = 0; // IST not used
    desc->options = 0x8E; // interrupt gate, 0 DPL
    desc->reserved = 0;
}

void initIDT(){
    initIDTEntry(&idt[IDT_DE_DIV_ZERO], divideByZeroISR);
    //TODO code a way to initialize various entries declared in the idt header file
}

void initIDTR(){
    idtr.size = sizeof(idt) - 1; // assign size of interrupt descriptor table
    idtr.address = (uint64_t)&idt; // assign interrupt descriptor table's address
}



// HANDLER FUNCTIONS

void divideByZeroISR(){

}