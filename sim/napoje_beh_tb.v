`timescale 1ns / 1ps

module napoje_beh_tb;

    // Wejscia
    reg user_ok;
    reg user_break;
    reg user_sel;
    reg clk;
    reg reset;
    reg nr_w;
    reg [2:0] adres;
    reg [7:0] dane_we;
    reg moneta_in;

    // Wyjscia
    wire [7:0] dane_wy;
    wire podajnik_trig;
    wire [1:0] nr_podajnika;
    wire reszta_out;

    // UUT
    napoje_beh uut (
        .user_ok(user_ok), 
        .user_break(user_break), 
        .user_sel(user_sel), 
        .clk(clk), 
        .reset(reset), 
        .nr_w(nr_w), 
        .adres(adres), 
        .dane_we(dane_we), 
        .dane_wy(dane_wy), 
        .moneta_in(moneta_in), 
        .podajnik_trig(podajnik_trig), 
        .nr_podajnika(nr_podajnika), 
        .reszta_out(reszta_out)
    );

    // Generowanie zegara
    always #5 clk = ~clk;

    initial begin
        // Inicjalizacja wejsc
        user_ok = 0;
        user_break = 0;
        user_sel = 0;
        clk = 0;
        reset = 1;
        nr_w = 0;
        adres = 0;
        dane_we = 0;
        moneta_in = 0;

        // oczekuje na reset
        #100;
        reset = 0;

        // Test case 1: Wybor napoju i mocy
        #10;
        user_sel = 1; // Wybierz napoj
        #10;
        user_sel = 0;
        #10;
        user_ok = 1; // Zatwierdz wybor napoju
        #10;
        user_ok = 0;
        #10;
        user_sel = 1; // Wybierz moc
        #10;
        user_sel = 0;
        #10;
        user_ok = 1; // Zatwierdz wybor mocy
        #10;
        user_ok = 0;

        // Test case 2: Wrzucenie monet
        #10;
        moneta_in = 1; // Wrzuc monete
        #10;
        moneta_in = 0;
        #10;
        moneta_in = 1; // Wrzuc kolejna monete
        #10;
        moneta_in = 0;

        // Test case 3: Zatwierdzenie platnosci
        #10;
        user_ok = 1; // Zatwierdz platnosc
        #10;
        user_ok = 0;

        // Test case 4: Przerwanie operacji
        #10;
        user_break = 1; // Przerwij operacje
        #10;
        user_break = 0;

        // Test case 5: Reset
        #10;
        reset = 1; // Zresetuj automat
        #10;
        reset = 0;

        // Koniec symulacji
        #100;
        $finish;
    end

endmodule
