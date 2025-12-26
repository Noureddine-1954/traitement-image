function gui_universal()
    % ====================================================================
    % 1. CROSS-PLATFORM SETUP
    % ====================================================================
    
    % Check if we are running in Octave
    isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
    
    % If Octave, try to load the image package (if installed)
    if isOctave
        try
            pkg load image;
        catch
            disp('Warning: "image" package not found. Using basic fallback functions.');
        end
    end

    % Shared variable for the current image
    currentImg = [];

    % Create Main Figure
    f = figure('Name', 'Universal Image Tool (MATLAB/Octave)', ...
               'NumberTitle', 'off', ...
               'Position', [100, 100, 300, 800], ...
               'MenuBar', 'none', ...
               'Resize', 'off', ...
               'Color', [0.94 0.94 0.94]);

    % Layout Constants
    btnH = 25; btnW = 260; pad = 5; currentY = 760; colX = 20;

    % ====================================================================
    % 2. UI LAYOUT (Button Names Kept English)
    % ====================================================================

    % --- Files ---
    add_label('--- FILES ---');
    add_button('Open Image', @cb_load);
    add_button('Save Image', @cb_save);

    % --- Creation ---
    add_label('--- CREATION ---');
    % Renamed function handles to match PDF names
    add_button('Image Black', @(s,e) create_wrapper(@image_noire));
    add_button('Image White', @(s,e) create_wrapper(@image_blanche));
    add_button('Checkerboard', @(s,e) create_wrapper(@creerImgBlancNoir));
    add_button('Random RGB', @(s,e) create_wrapper(@initImageRGB));

    % --- Effects ---
    add_label('--- EFFECTS ---');
    add_button('Negative', @(s,e) apply_effect(@negatif));
    add_button('Flip Horizontal', @(s,e) apply_effect(@flipH));
    % flipV is extra, kept as helper
    add_button('Flip Vertical', @(s,e) apply_effect(@flipV)); 
    % Renamed to symetrie (Q19)
    add_button('Symmetry H (Mirror)', @(s,e) apply_effect(@symetrie)); 
    add_button('Symmetry V (Mirror)', @(s,e) apply_effect(@symetrieV));
    % Renamed to grayscale (Q20)
    add_button('Grayscale', @(s,e) apply_effect(@grayscale));

    % --- Analysis ---
    add_label('--- ANALYSIS ---');
    % Renamed analysis functions (Q8, Q9, Q10)
    add_button('Luminance', @(s,e) show_info(@luminance, 'Luminance'));
    add_button('Contrast', @(s,e) show_info(@constrast, 'Contrast'));
    add_button('Max Value', @(s,e) show_info(@profondeur, 'Max Intensity'));
    add_button('Dimensions', @cb_size);

    % --- Combination ---
    add_label('--- COMBINATION ---');
    add_button('Stack Vertical', @cb_poserV);
    add_button('Stack Horizontal', @cb_poserH);


    % ====================================================================
    % 3. CALLBACKS
    % ====================================================================

    function cb_load(~, ~)
        [file, path] = uigetfile({'*.jpg;*.jpeg;*.png;*.bmp;*.tif'}, 'Open Image');
        if isequal(file, 0), return; end
        try
            % Using "lectureImage" as per PDF Q1
            currentImg = lectureImage(fullfile(path, file));
            
            if size(currentImg, 3) == 4
                currentImg = currentImg(:,:,1:3);
            end
            % Using "AfficherImg" as per PDF Q1
            AfficherImg(currentImg);
        catch
            msgbox('Error loading image. Check format.');
        end
    end

    function cb_save(~, ~)
        if isempty(currentImg), return; end
        [file, path] = uiputfile({'*.png'}, 'Save Image');
        if isequal(file, 0), return; end
        try
            % Using "saveImage" as per PDF Q1
            saveImage(currentImg, fullfile(path, file));
            msgbox('Saved!');
        catch
            msgbox('Error saving image.');
        end
    end

    function create_wrapper(func)
        [h, w] = ask_dims();
        if isempty(h), return; end
        currentImg = func(h, w);
        AfficherImg(currentImg);
    end

    function apply_effect(func)
        if isempty(currentImg), msgbox('Load image first'); return; end
        currentImg = func(currentImg);
        AfficherImg(currentImg);
    end

    function show_info(func, title)
        if isempty(currentImg), msgbox('Load image first'); return; end
        val = func(currentImg);
        msgbox(sprintf('%s: %.2f', title, val));
    end

    function cb_size(~, ~)
        if isempty(currentImg), return; end
        sz = size(currentImg);
        if length(sz) == 3
            msgbox(sprintf('%d x %d (RGB)', sz(1), sz(2)));
        else
            msgbox(sprintf('%d x %d (Grayscale)', sz(1), sz(2)));
        end
    end

    function cb_poserV(~, ~)
        if isempty(currentImg), return; end
        [file, path] = uigetfile({'*.jpg;*.jpeg;*.png;*.bmp;*.tif'}, 'Select Image 2');
        if isequal(file, 0), return; end
        
        img2 = lectureImage(fullfile(path, file));
        if size(img2, 3) == 4, img2 = img2(:,:,1:3); end

        if size(currentImg, 3) ~= size(img2, 3)
            msgbox('Error: Cannot combine RGB and Grayscale'); return;
        end

        % Resize img2 width to match (using helper for compatibility)
        if size(currentImg, 2) ~= size(img2, 2)
            img2 = safe_resize(img2, [NaN, size(currentImg, 2)]);
        end

        % Using "poserV" as per PDF Q14
        currentImg = poserV(currentImg, img2);
        AfficherImg(currentImg);
    end

    function cb_poserH(~, ~)
        if isempty(currentImg), return; end
        [file, path] = uigetfile({'*.jpg;*.jpeg;*.png;*.bmp;*.tif'}, 'Select Image 2');
        if isequal(file, 0), return; end
        
        img2 = lectureImage(fullfile(path, file));
        if size(img2, 3) == 4, img2 = img2(:,:,1:3); end

        if size(currentImg, 3) ~= size(img2, 3)
            msgbox('Error: Cannot combine RGB and Grayscale'); return;
        end

        % Resize img2 height to match
        if size(currentImg, 1) ~= size(img2, 1)
            img2 = safe_resize(img2, [size(currentImg, 1), NaN]);
        end

        % Using "poserH" as per PDF Q15
        currentImg = poserH(currentImg, img2);
        AfficherImg(currentImg);
    end

    % ====================================================================
    % 4. LOGIC (Renamed per PDF Requirements)
    % ====================================================================

    % --- I/O Functions ---
    function img = lectureImage(chemin)
        img = imread(chemin);
    end

    function AfficherImg(img)
        % Using "AfficherImg" name
        figure('Name', 'Result', 'NumberTitle', 'off', 'MenuBar', 'none'); 
        imshow(img);
    end

    function saveImage(img, chemin)
        imwrite(img, chemin);
    end

    % --- Creation ---
    
    function img = image_noire(h, w)
        % Was create_black
        img = zeros(h, w, 'uint8');
    end

    function img = image_blanche(h, w)
        % Was create_white
        img = 255 * ones(h, w, 'uint8');
    end

    function img = creerImgBlancNoir(h, w)
        % Was create_checker
        [X, Y] = meshgrid(1:w, 1:h);
        mask = mod(X + Y, 2) == 1;
        img = zeros(h, w, 'uint8');
        img(mask) = 255; 
    end

    function img = initImageRGB(h, w)
        % Was create_rgb
        img = randi([0 255], h, w, 3);
        img = uint8(img);
    end

    % --- Effects ---
    
    function img = negatif(img)
        img = 255 - img;
    end

    function img = flipH(img)
        img = fliplr(img);
    end

    function img = flipV(img)
        img = flipud(img);
    end

    function img = symetrie(img)
        % Was symetrieH (Horizontal Symmetry / Mirror)
        % Q19 asks for "symetrie"
        [~, w, ~] = size(img);
        half = floor(w / 2);
        img(:, end-half+1:end, :) = fliplr(img(:, 1:half, :));
    end

    function img = symetrieV(img)
        % Extra logic for Vertical Mirror
        [h, ~, ~] = size(img);
        half = floor(h / 2);
        img(end-half+1:end, :, :) = flipud(img(1:half, :, :));
    end

    % --- Compatibility/Conversion ---
    
    function imgOut = grayscale(img)
        % Was safe_grayscale
        % Q20 asks for "grayscale"
        if size(img, 3) == 1
            imgOut = img; return;
        end
        
        % PDF Algorithm: Average of Max and Min of RGB channels
        imgD = double(img);
        maxV = max(imgD, [], 3);
        minV = min(imgD, [], 3);
        imgOut = uint8(floor((maxV + minV) / 2));
    end

    function imgOut = safe_resize(img, targetDim)
        % Helper remains safe_resize (internal utility)
        [h, w, c] = size(img);
        
        scale = 1;
        if isnan(targetDim(1)) 
            scale = targetDim(2) / w;
            newH = round(h * scale);
            newW = targetDim(2);
        elseif isnan(targetDim(2))
            scale = targetDim(1) / h;
            newH = targetDim(1);
            newW = round(w * scale);
        else
            newH = targetDim(1);
            newW = targetDim(2);
        end
        
        try
            imgOut = imresize(img, [newH, newW]);
        catch
            row_inds = round(linspace(1, h, newH));
            col_inds = round(linspace(1, w, newW));
            row_inds = max(min(row_inds, h), 1);
            col_inds = max(min(col_inds, w), 1);
            imgOut = img(row_inds, col_inds, :);
        end
    end

    % --- Analysis ---
    
    function val = luminance(img)
        % Was calc_lum
        imgD = double(img);
        val = mean(imgD(:));
    end

    function val = constrast(img)
        % Was calc_con
        imgD = double(img);
        if size(imgD, 3) == 3
            imgD = mean(imgD, 3);
        end
        val = var(imgD(:));
    end

    function val = profondeur(img)
        % Was calc_max
        val = max(img(:));
    end
    
    % --- Combination ---
    
    function img = poserV(img1, img2)
        % Extracted logic for Q14
        img = [img1; img2];
    end
    
    function img = poserH(img1, img2)
        % Extracted logic for Q15
        img = [img1, img2];
    end

    % ====================================================================
    % 5. UI UTILITIES
    % ====================================================================

    function [h, w] = ask_dims()
        answer = inputdlg({'Height (px):', 'Width (px):'}, 'Size', 1, {'200', '200'});
        if isempty(answer), h=[]; w=[]; return; end
        h = str2double(answer{1});
        w = str2double(answer{2});
        if isnan(h) || isnan(w) || h<1 || w<1
             msgbox('Invalid dimensions'); h=[]; w=[];
        end
    end

    function add_button(txt, func)
        uicontrol(f, 'Style', 'pushbutton', 'String', txt, ...
                  'Position', [colX, currentY, btnW, btnH], ...
                  'Callback', func);
        currentY = currentY - (btnH + pad);
    end

    function add_label(txt)
        currentY = currentY - 5;
        uicontrol(f, 'Style', 'text', 'String', txt, 'FontWeight', 'bold', ...
                  'Position', [colX, currentY, btnW, 18], ...
                  'BackgroundColor', [0.94 0.94 0.94], 'HorizontalAlignment', 'left');
        currentY = currentY - (22 + pad);
    end

end