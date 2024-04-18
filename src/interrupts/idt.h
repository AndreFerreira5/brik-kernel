#ifndef BRIKERNEL_IDT_H
#define BRIKERNEL_IDT_H

#define IDT_DE_DIV_ZERO 0
#define IDT_DE_PAGE_FAULT 14

extern struct IDTR idtr;

void initIDT();
void initIDTR();

#endif //BRIKERNEL_IDT_H
