module secure_boot (
    input  wire clk,        // Boot clock
    input  wire power_on,   // Power ON signal
    output reg  boot_ok,    // Boot success indicator
    output wire boot_fail   // Boot failure indicator
);

    // ----------------------------
    // Boot ROM (Trusted Signature)
    // ----------------------------
    wire [7:0] boot_rom;
    assign boot_rom = 8'b10101010;   // Trusted value

    // ----------------------------
    // Firmware ROM (Firmware Image)
    // ----------------------------
    wire [7:0] firmware_rom;
    assign firmware_rom = 8'b11110000; 
    // Change to 8'b11110000 to simulate tampering

    // ----------------------------
    // Firmware Verification
    // ----------------------------
    wire firmware_valid;
    assign firmware_valid = (boot_rom == firmware_rom);

    // ----------------------------
    // Boot Enable Logic
    // ----------------------------
    wire boot_condition;
    assign boot_condition = firmware_valid & power_on;

    // ----------------------------
    // Boot Decision Register
    // ----------------------------
    always @(posedge clk) begin
        boot_ok <= boot_condition;
    end

    // ----------------------------
    // Boot Fail Signal
    // ----------------------------
    assign boot_fail = ~firmware_valid;

endmodule
