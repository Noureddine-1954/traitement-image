classdef ImgLib
    % IMGLIB Contains all the image processing functions 
    % requested in the MiniProjet PDF.
    % Call them using: ImgLib.functionName()

    methods (Static)
        
        [cite_start]% --- PARTIE I: I/O [cite: 53-67] ---

        function img = lectureImage(chemin)
            % "Ouvrir une image jpg ou bmp et retourner une matrice"
            img = imread(chemin);
        end

        function AfficherImg(img)
            % "Prend en argument une image ensuite elle l'affiche"
            figure('Name', 'Result', 'NumberTitle', 'off', 'MenuBar', 'none'); 
            imshow(img);
            axis off;
        end

        function saveImage(img, chemin)
            % "Enregistre cette image dans le disque dur"
            if nargin < 2
                imwrite(img, 'image1.png');
            else
                imwrite(img, chemin);
            end
        end

        % --- PARTIE II: NOIR ET BLANC ---

        function img = image_noire(h, w)
            % Q3: "Générer une image en noir... valeur 0"
            img = zeros(h, w, 'uint8');
        end

        function img = image_blanche(h, w)
            % Q4: "Générer une image... valeur 1" (255)
            img = 255 * ones(h, w, 'uint8');
        end

        function img = creerImgBlancNoir(h, w)
            % Q5: "Pixel (i,j) est donné par (i+j)%2"
            [X, Y] = meshgrid(1:w, 1:h);
            mask = mod(X + Y, 2) == 1;
            img = zeros(h, w, 'uint8');
            img(mask) = 255; 
        end

        function img = negatif(imgIn)
            % Q6: "Construit le négatif... 0 devient 1"
            img = 255 - imgIn;
        end

        % --- PARTIE III: NIVEAU DE GRIS ---

        function val = luminance(img)
            % Q8: "Moyenne de tous les pixels de l'image"
            imgD = double(img);
            val = mean(imgD(:));
        end

        function val = constrast(img)
            % Q9: "Variance des niveaux de gris"
            imgD = double(img);
            if size(imgD, 3) == 3
                imgD = mean(imgD, 3);
            end
            val = var(imgD(:));
        end

        function val = profondeur(img)
            % Q10: "Retourne la valeur maximale d'un pixel"
            val = max(img(:));
        end

        % --- PARTIE IV: OPERATIONS ELEMENTAIRES ---

        function img = inverser(imgIn)
            % Q12: "Le ton d'un pixel est p-v"
            img = 255 - imgIn;
        end

        function img = flipH(imgIn)
            % Q13: "Symétrie d'axe vertical"
            img = fliplr(imgIn);
        end
        
        function img = flipV(imgIn)
            % Extra Helper
            img = flipud(imgIn);
        end

        function img = poserV(img1, img2)
            % Q14: "Posant img1 sur img2"
            img = [img1; img2];
        end

        function img = poserH(img1, img2)
            % Q15: "Posant img2 à droite de img1"
            img = [img1, img2];
        end

        % --- PARTIE V: RGB ---

        function img = initImageRGB(h, w)
            % Q18: "Initialiser... d'une manière aléatoire"
            img = randi([0 255], h, w, 3);
            img = uint8(img);
        end

        function img = symetrie(imgIn)
            % Q19: "Symétrie par rapport à l'axe horizontal"
            [~, w, ~] = size(imgIn);
            half = floor(w / 2);
            img = imgIn;
            img(:, end-half+1:end, :) = fliplr(img(:, 1:half, :));
        end
        
        function img = symetrieV(imgIn)
            % Extra Helper
            [h, ~, ~] = size(imgIn);
            half = floor(h / 2);
            img = imgIn;
            img(end-half+1:end, :, :) = flipud(img(1:half, :, :));
        end

        function imgOut = grayscale(imageRGB)
            % Q20: "Moyenne de ces valeurs maximales et minimales"
            if size(imageRGB, 3) == 1
                imgOut = imageRGB; return;
            end
            
            imgD = double(imageRGB);
            maxV = max(imgD, [], 3);
            minV = min(imgD, [], 3);
            imgOut = uint8(floor((maxV + minV) / 2));
        end

    end
end